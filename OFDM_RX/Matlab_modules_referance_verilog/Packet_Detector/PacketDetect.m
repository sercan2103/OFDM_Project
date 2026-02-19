function [startOffset,M] = asdasd(x, chanBW, varargin)

narginchk(2,4);
nargoutchk(0,2);

if nargout==2
    M = [];
end

validateattributes(x, {'single','double'}, {'2d','finite'}, mfilename, 'signal input');
startOffset = [];

if isempty(x)
    return;
end

if nargin == 2
    threshold = 0.5;
    offset = 0;
elseif nargin == 3
    threshold = 0.5;
    validateattributes(varargin{1}, {'double'}, {'integer','scalar','>=',0}, mfilename, 'offset');
    offset = varargin{1};
else
    validateattributes(varargin{1}, {'double'}, {'integer','scalar','>=',0}, mfilename, 'offset');
    validateattributes(varargin{2}, {'double'}, {'real','scalar','>',0,'<=',1}, mfilename, 'threshold');
    offset = varargin{1};
    threshold = varargin{2};
end

if offset > size(x,1) - 1
    error('wlan:shared:InvalidOffsetValue', 'Offset değeri giriş sinyali uzunluğunu aşamaz.');
end

validBWs = {'CBW5', 'CBW10', 'CBW20', 'CBW40', 'CBW80', 'CBW160', 'CBW320'};
chanBW = validatestring(chanBW, validBWs, mfilename, 'ChannelBandwidth');

Td = 0.8e-6;
                
switch chanBW
    case {'CBW5', 'CBW10', 'CBW20'}
        symbolLength = Td/(1/20e6);
    case 'CBW40'
        symbolLength = Td/(1/40e6);
    case {'CBW80'}
        symbolLength = Td/(1/80e6);
    case {'CBW160'}
        symbolLength = Td/(1/160e6);
    otherwise % CBW320
        symbolLength = Td/(1/320e6);
end

lenLSTF = symbolLength*10;
lenHalfLSTF = lenLSTF/2;
inpLength = (size(x,1) - offset); 

if inpLength <= lenHalfLSTF
    numPadSamples = lenLSTF - inpLength;
else
    numPadSamples = lenHalfLSTF*ceil(inpLength/lenHalfLSTF) - inpLength;
end

padSamples = zeros(numPadSamples, size(x,2));
numBlocks = (inpLength + numPadSamples)/lenHalfLSTF;

if nargout==2
    DS = zeros(size(x,1) + length(padSamples) - offset -2*symbolLength + 1, 1);
    
    if numBlocks > 2
        for n=1:numBlocks-2
            buffer = x((n-1)*lenHalfLSTF + (1:lenLSTF) + offset, :);
            [startOffset, out] = correlateSamples(buffer, symbolLength, lenLSTF, threshold);
            DS((n-1)*lenHalfLSTF + 1:lenHalfLSTF*n, 1) = out(1:lenHalfLSTF);
            
            if ~(isempty(startOffset))
                startOffset = startOffset + (n-1)*lenHalfLSTF;
                DS((n-1)*lenHalfLSTF + (1:length(out)), 1) = out;
                M = DS(1:(n-1)*lenHalfLSTF + length(out));
                return;
            end
        end
        blkOffset = lenHalfLSTF*(numBlocks-2);
        buffer = [x(blkOffset + 1 + offset:end, :); padSamples];
        [startOffset, out] = correlateSamples(buffer, symbolLength, lenLSTF, threshold);
        
        if ~(isempty(startOffset))
            startOffset = startOffset + blkOffset;
        end
        
        DS(blkOffset + 1:end, 1) = out;
        M = DS(1:end-length(padSamples)); 
    else
        buffer = [x(offset + 1:end, :); padSamples];
        [startOffset, out] = correlateSamples(buffer, symbolLength, lenLSTF, threshold);
        M = double(out);
    end
else
    if numBlocks > 2
        for n=1:numBlocks-2
            buffer = x((n-1)*lenHalfLSTF + (1:lenLSTF) + offset, :);
            startOffset = correlateSamples(buffer, symbolLength, lenLSTF, threshold);
            if ~(isempty(startOffset))
                startOffset = startOffset + (n-1)*lenHalfLSTF;
                return;
            end
        end
        blkOffset = lenHalfLSTF*(numBlocks-2);
        buffer = [x(blkOffset + 1 + offset:end, :); padSamples];
        startOffset = correlateSamples(buffer, symbolLength, lenLSTF, threshold);
        if ~(isempty(startOffset))
            startOffset = startOffset + blkOffset;
        end
    else
        buffer = [x(offset + 1:end, :); padSamples];
        startOffset = correlateSamples(buffer, symbolLength, lenLSTF, threshold); 
    end
end

end

function [packetStart,Mn] = correlateSamples(rxSig, symbolLength, lenLSTF, threshold)

correlationLength = lenLSTF - (symbolLength*2);
pNoise = eps;
weights = ones(symbolLength, 1);
index = 1:correlationLength + 1;
packetStart = [];

rxDelayed = rxSig(symbolLength + 1:end , :); 
rx = rxSig(1:end-symbolLength, :);  

C = sum(filter(weights, 1,(conj(rxDelayed).*rx)), 2);

CS = C(symbolLength:end)./symbolLength;

P = sum(filter(weights, 1, (abs(rxDelayed).^2+abs(rx).^2)/2)./symbolLength, 2);
PS = P(symbolLength:end) + pNoise;

Mn = abs(CS).^2./PS.^2;

N = Mn > threshold;

if (sum(N) >= symbolLength*1.5)
    found = index(N);
    packetStart = found(1) - 1;
    if sum((found(2:symbolLength) - found(1))>symbolLength*3)
        packetStart = [];
    end
end
end