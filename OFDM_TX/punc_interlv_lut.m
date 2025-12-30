function [idx_o, punc_o] = punc_interlv_lut(rate, idx_i)
% PUNC_INTERLV_LUT MATLAB model of the Verilog LUT
% Inputs:
%   rate: 5-bit integer (0-31)
%   idx_i: 9-bit integer input index
% Outputs:
%   idx_o: 18-bit integer (concatenated 9-bit high, 9-bit low)
%   punc_o: 2-bit integer (concatenated 1-bit high, 1-bit low)

    % Default values
    idx_o = bitconcat(uint32(511), 9, uint32(511), 9);
    punc_o = 3; % 2'b11

    switch rate
        case 8
            switch idx_i
                case 0
                    idx_o = 13312;
                    punc_o = 0;
                case 1
                    idx_o = 261681;
                    punc_o = 2;
                case 2
                    idx_o = 50248;
                    punc_o = 0;
                case 3
                    idx_o = 261753;
                    punc_o = 2;
                case 4
                    idx_o = 87184;
                    punc_o = 0;
                case 5
                    idx_o = 261825;
                    punc_o = 2;
                case 6
                    idx_o = 124120;
                    punc_o = 0;
                case 7
                    idx_o = 261897;
                    punc_o = 2;
                case 8
                    idx_o = 161056;
                    punc_o = 0;
                case 9
                    idx_o = 261969;
                    punc_o = 2;
                case 10
                    idx_o = 872;
                    punc_o = 0;
                case 11
                    idx_o = 261656;
                    punc_o = 2;
                case 12
                    idx_o = 37426;
                    punc_o = 0;
                case 13
                    idx_o = 261728;
                    punc_o = 2;
                case 14
                    idx_o = 74362;
                    punc_o = 0;
                case 15
                    idx_o = 261800;
                    punc_o = 2;
                case 16
                    idx_o = 111298;
                    punc_o = 0;
                case 17
                    idx_o = 261872;
                    punc_o = 2;
                case 18
                    idx_o = 148234;
                    punc_o = 0;
                case 19
                    idx_o = 261944;
                    punc_o = 2;
                case 20
                    idx_o = 185170;
                    punc_o = 0;
                case 21
                    idx_o = 261634;
                    punc_o = 2;
                case 22
                    idx_o = 24601;
                    punc_o = 0;
                case 23
                    idx_o = 261706;
                    punc_o = 2;
                case 24
                    idx_o = 61537;
                    punc_o = 0;
                case 25
                    idx_o = 261778;
                    punc_o = 2;
                case 26
                    idx_o = 98473;
                    punc_o = 0;
                case 27
                    idx_o = 261850;
                    punc_o = 2;
                case 28
                    idx_o = 135409;
                    punc_o = 0;
                case 29
                    idx_o = 261922;
                    punc_o = 2;
                case 30
                    idx_o = 172345;
                    punc_o = 0;
                case 31
                    idx_o = 261994;
                    punc_o = 2;
                case 32
                    idx_o = 14851;
                    punc_o = 0;
                case 33
                    idx_o = 261684;
                    punc_o = 2;
                case 34
                    idx_o = 51787;
                    punc_o = 0;
                case 35
                    idx_o = 261756;
                    punc_o = 2;
                case 36
                    idx_o = 88723;
                    punc_o = 0;
                case 37
                    idx_o = 261828;
                    punc_o = 2;
                case 38
                    idx_o = 125659;
                    punc_o = 0;
                case 39
                    idx_o = 261900;
                    punc_o = 2;
                case 40
                    idx_o = 162595;
                    punc_o = 0;
                case 41
                    idx_o = 261972;
                    punc_o = 2;
                case 42
                    idx_o = 2411;
                    punc_o = 0;
                case 43
                    idx_o = 261659;
                    punc_o = 2;
                case 44
                    idx_o = 38965;
                    punc_o = 0;
                case 45
                    idx_o = 261731;
                    punc_o = 2;
                case 46
                    idx_o = 75901;
                    punc_o = 0;
                case 47
                    idx_o = 261803;
                    punc_o = 2;
                case 48
                    idx_o = 112837;
                    punc_o = 0;
                case 49
                    idx_o = 261875;
                    punc_o = 2;
                case 50
                    idx_o = 149773;
                    punc_o = 0;
                case 51
                    idx_o = 261947;
                    punc_o = 2;
                case 52
                    idx_o = 186709;
                    punc_o = 0;
                case 53
                    idx_o = 261637;
                    punc_o = 2;
                case 54
                    idx_o = 26140;
                    punc_o = 0;
                case 55
                    idx_o = 261709;
                    punc_o = 2;
                case 56
                    idx_o = 63076;
                    punc_o = 0;
                case 57
                    idx_o = 261781;
                    punc_o = 2;
                case 58
                    idx_o = 100012;
                    punc_o = 0;
                case 59
                    idx_o = 261853;
                    punc_o = 2;
                case 60
                    idx_o = 136948;
                    punc_o = 0;
                case 61
                    idx_o = 261925;
                    punc_o = 2;
                case 62
                    idx_o = 173884;
                    punc_o = 0;
                case 63
                    idx_o = 261997;
                    punc_o = 2;
                case 64
                    idx_o = 17416;
                    punc_o = 0;
                case 65
                    idx_o = 261689;
                    punc_o = 2;
                case 66
                    idx_o = 54352;
                    punc_o = 0;
                case 67
                    idx_o = 261761;
                    punc_o = 2;
                case 68
                    idx_o = 91288;
                    punc_o = 0;
                case 69
                    idx_o = 261833;
                    punc_o = 2;
                case 70
                    idx_o = 128224;
                    punc_o = 0;
                case 71
                    idx_o = 261905;
                    punc_o = 2;
                case 72
                    idx_o = 165160;
                    punc_o = 0;
                case 73
                    idx_o = 261977;
                    punc_o = 2;
                case 74
                    idx_o = 4976;
                    punc_o = 0;
                case 75
                    idx_o = 261664;
                    punc_o = 2;
                case 76
                    idx_o = 41530;
                    punc_o = 0;
                case 77
                    idx_o = 261736;
                    punc_o = 2;
                case 78
                    idx_o = 78466;
                    punc_o = 0;
                case 79
                    idx_o = 261808;
                    punc_o = 2;
                case 80
                    idx_o = 115402;
                    punc_o = 0;
                case 81
                    idx_o = 261880;
                    punc_o = 2;
                case 82
                    idx_o = 152338;
                    punc_o = 0;
                case 83
                    idx_o = 261952;
                    punc_o = 2;
                case 84
                    idx_o = 189274;
                    punc_o = 0;
                case 85
                    idx_o = 261642;
                    punc_o = 2;
                case 86
                    idx_o = 28705;
                    punc_o = 0;
                case 87
                    idx_o = 261714;
                    punc_o = 2;
                case 88
                    idx_o = 65641;
                    punc_o = 0;
                case 89
                    idx_o = 261786;
                    punc_o = 2;
                case 90
                    idx_o = 102577;
                    punc_o = 0;
                case 91
                    idx_o = 261858;
                    punc_o = 2;
                case 92
                    idx_o = 139513;
                    punc_o = 0;
                case 93
                    idx_o = 261930;
                    punc_o = 2;
                case 94
                    idx_o = 176449;
                    punc_o = 0;
                case 95
                    idx_o = 262002;
                    punc_o = 2;
                case 96
                    idx_o = 18955;
                    punc_o = 0;
                case 97
                    idx_o = 261692;
                    punc_o = 2;
                case 98
                    idx_o = 55891;
                    punc_o = 0;
                case 99
                    idx_o = 261764;
                    punc_o = 2;
                case 100
                    idx_o = 92827;
                    punc_o = 0;
                case 101
                    idx_o = 261836;
                    punc_o = 2;
                case 102
                    idx_o = 129763;
                    punc_o = 0;
                case 103
                    idx_o = 261908;
                    punc_o = 2;
                case 104
                    idx_o = 166699;
                    punc_o = 0;
                case 105
                    idx_o = 261980;
                    punc_o = 2;
                case 106
                    idx_o = 6515;
                    punc_o = 0;
                case 107
                    idx_o = 261667;
                    punc_o = 2;
                case 108
                    idx_o = 43069;
                    punc_o = 0;
                case 109
                    idx_o = 261739;
                    punc_o = 2;
                case 110
                    idx_o = 80005;
                    punc_o = 0;
                case 111
                    idx_o = 261811;
                    punc_o = 2;
                case 112
                    idx_o = 116941;
                    punc_o = 0;
                case 113
                    idx_o = 261883;
                    punc_o = 2;
                case 114
                    idx_o = 153877;
                    punc_o = 0;
                case 115
                    idx_o = 261955;
                    punc_o = 2;
                case 116
                    idx_o = 190813;
                    punc_o = 0;
                case 117
                    idx_o = 261645;
                    punc_o = 2;
                case 118
                    idx_o = 30244;
                    punc_o = 0;
                case 119
                    idx_o = 261717;
                    punc_o = 2;
                case 120
                    idx_o = 67180;
                    punc_o = 0;
                case 121
                    idx_o = 261789;
                    punc_o = 2;
                case 122
                    idx_o = 104116;
                    punc_o = 0;
                case 123
                    idx_o = 261861;
                    punc_o = 2;
                case 124
                    idx_o = 141052;
                    punc_o = 0;
                case 125
                    idx_o = 261933;
                    punc_o = 2;
                case 126
                    idx_o = 177988;
                    punc_o = 0;
                case 127
                    idx_o = 262005;
                    punc_o = 2;
                case 128
                    idx_o = 21520;
                    punc_o = 0;
                case 129
                    idx_o = 261697;
                    punc_o = 2;
                case 130
                    idx_o = 58456;
                    punc_o = 0;
                case 131
                    idx_o = 261769;
                    punc_o = 2;
                case 132
                    idx_o = 95392;
                    punc_o = 0;
                case 133
                    idx_o = 261841;
                    punc_o = 2;
                case 134
                    idx_o = 132328;
                    punc_o = 0;
                case 135
                    idx_o = 261913;
                    punc_o = 2;
                case 136
                    idx_o = 169264;
                    punc_o = 0;
                case 137
                    idx_o = 261985;
                    punc_o = 2;
                case 138
                    idx_o = 9080;
                    punc_o = 0;
                case 139
                    idx_o = 261672;
                    punc_o = 2;
                case 140
                    idx_o = 45634;
                    punc_o = 0;
                case 141
                    idx_o = 261744;
                    punc_o = 2;
                case 142
                    idx_o = 82570;
                    punc_o = 0;
                case 143
                    idx_o = 261816;
                    punc_o = 2;
                case 144
                    idx_o = 119506;
                    punc_o = 0;
                case 145
                    idx_o = 261888;
                    punc_o = 2;
                case 146
                    idx_o = 156442;
                    punc_o = 0;
                case 147
                    idx_o = 261960;
                    punc_o = 2;
                case 148
                    idx_o = 193378;
                    punc_o = 0;
                case 149
                    idx_o = 261650;
                    punc_o = 2;
                case 150
                    idx_o = 32809;
                    punc_o = 0;
                case 151
                    idx_o = 261722;
                    punc_o = 2;
                case 152
                    idx_o = 69745;
                    punc_o = 0;
                case 153
                    idx_o = 261794;
                    punc_o = 2;
                case 154
                    idx_o = 106681;
                    punc_o = 0;
                case 155
                    idx_o = 261866;
                    punc_o = 2;
                case 156
                    idx_o = 143617;
                    punc_o = 0;
                case 157
                    idx_o = 261938;
                    punc_o = 2;
                case 158
                    idx_o = 180553;
                    punc_o = 0;
                case 159
                    idx_o = 262010;
                    punc_o = 2;
                case 160
                    idx_o = 23059;
                    punc_o = 0;
                case 161
                    idx_o = 261700;
                    punc_o = 2;
                case 162
                    idx_o = 59995;
                    punc_o = 0;
                case 163
                    idx_o = 261772;
                    punc_o = 2;
                case 164
                    idx_o = 96931;
                    punc_o = 0;
                case 165
                    idx_o = 261844;
                    punc_o = 2;
                case 166
                    idx_o = 133867;
                    punc_o = 0;
                case 167
                    idx_o = 261916;
                    punc_o = 2;
                case 168
                    idx_o = 170803;
                    punc_o = 0;
                case 169
                    idx_o = 261988;
                    punc_o = 2;
                case 170
                    idx_o = 10619;
                    punc_o = 0;
                case 171
                    idx_o = 261675;
                    punc_o = 2;
                case 172
                    idx_o = 47173;
                    punc_o = 0;
                case 173
                    idx_o = 261747;
                    punc_o = 2;
                case 174
                    idx_o = 84109;
                    punc_o = 0;
                case 175
                    idx_o = 261819;
                    punc_o = 2;
                case 176
                    idx_o = 121045;
                    punc_o = 0;
                case 177
                    idx_o = 261891;
                    punc_o = 2;
                case 178
                    idx_o = 157981;
                    punc_o = 0;
                case 179
                    idx_o = 261963;
                    punc_o = 2;
                case 180
                    idx_o = 194917;
                    punc_o = 0;
                case 181
                    idx_o = 261653;
                    punc_o = 2;
                case 182
                    idx_o = 34348;
                    punc_o = 0;
                case 183
                    idx_o = 261725;
                    punc_o = 2;
                case 184
                    idx_o = 71284;
                    punc_o = 0;
                case 185
                    idx_o = 261797;
                    punc_o = 2;
                case 186
                    idx_o = 108220;
                    punc_o = 0;
                case 187
                    idx_o = 261869;
                    punc_o = 2;
                case 188
                    idx_o = 145156;
                    punc_o = 0;
                case 189
                    idx_o = 261941;
                    punc_o = 2;
                case 190
                    idx_o = 182092;
                    punc_o = 0;
                case 191
                    idx_o = 262013;
                    punc_o = 2;
            end
        case 9
            switch idx_i
                case 0
                    idx_o = 12800;
                    punc_o = 0;
                case 1
                    idx_o = 37424;
                    punc_o = 0;
                case 2
                    idx_o = 62048;
                    punc_o = 0;
                case 3
                    idx_o = 86672;
                    punc_o = 0;
                case 4
                    idx_o = 111296;
                    punc_o = 0;
                case 5
                    idx_o = 135920;
                    punc_o = 0;
                case 6
                    idx_o = 160544;
                    punc_o = 0;
                case 7
                    idx_o = 185168;
                    punc_o = 0;
                case 8
                    idx_o = 12289;
                    punc_o = 0;
                case 9
                    idx_o = 36913;
                    punc_o = 0;
                case 10
                    idx_o = 61537;
                    punc_o = 0;
                case 11
                    idx_o = 86161;
                    punc_o = 0;
                case 12
                    idx_o = 110785;
                    punc_o = 0;
                case 13
                    idx_o = 135409;
                    punc_o = 0;
                case 14
                    idx_o = 160033;
                    punc_o = 0;
                case 15
                    idx_o = 184657;
                    punc_o = 0;
                case 16
                    idx_o = 13826;
                    punc_o = 0;
                case 17
                    idx_o = 38450;
                    punc_o = 0;
                case 18
                    idx_o = 63074;
                    punc_o = 0;
                case 19
                    idx_o = 87698;
                    punc_o = 0;
                case 20
                    idx_o = 112322;
                    punc_o = 0;
                case 21
                    idx_o = 136946;
                    punc_o = 0;
                case 22
                    idx_o = 161570;
                    punc_o = 0;
                case 23
                    idx_o = 186194;
                    punc_o = 0;
                case 24
                    idx_o = 13315;
                    punc_o = 0;
                case 25
                    idx_o = 37939;
                    punc_o = 0;
                case 26
                    idx_o = 62563;
                    punc_o = 0;
                case 27
                    idx_o = 87187;
                    punc_o = 0;
                case 28
                    idx_o = 111811;
                    punc_o = 0;
                case 29
                    idx_o = 136435;
                    punc_o = 0;
                case 30
                    idx_o = 161059;
                    punc_o = 0;
                case 31
                    idx_o = 185683;
                    punc_o = 0;
                case 32
                    idx_o = 16904;
                    punc_o = 0;
                case 33
                    idx_o = 41528;
                    punc_o = 0;
                case 34
                    idx_o = 66152;
                    punc_o = 0;
                case 35
                    idx_o = 90776;
                    punc_o = 0;
                case 36
                    idx_o = 115400;
                    punc_o = 0;
                case 37
                    idx_o = 140024;
                    punc_o = 0;
                case 38
                    idx_o = 164648;
                    punc_o = 0;
                case 39
                    idx_o = 189272;
                    punc_o = 0;
                case 40
                    idx_o = 16393;
                    punc_o = 0;
                case 41
                    idx_o = 41017;
                    punc_o = 0;
                case 42
                    idx_o = 65641;
                    punc_o = 0;
                case 43
                    idx_o = 90265;
                    punc_o = 0;
                case 44
                    idx_o = 114889;
                    punc_o = 0;
                case 45
                    idx_o = 139513;
                    punc_o = 0;
                case 46
                    idx_o = 164137;
                    punc_o = 0;
                case 47
                    idx_o = 188761;
                    punc_o = 0;
                case 48
                    idx_o = 17930;
                    punc_o = 0;
                case 49
                    idx_o = 42554;
                    punc_o = 0;
                case 50
                    idx_o = 67178;
                    punc_o = 0;
                case 51
                    idx_o = 91802;
                    punc_o = 0;
                case 52
                    idx_o = 116426;
                    punc_o = 0;
                case 53
                    idx_o = 141050;
                    punc_o = 0;
                case 54
                    idx_o = 165674;
                    punc_o = 0;
                case 55
                    idx_o = 190298;
                    punc_o = 0;
                case 56
                    idx_o = 17419;
                    punc_o = 0;
                case 57
                    idx_o = 42043;
                    punc_o = 0;
                case 58
                    idx_o = 66667;
                    punc_o = 0;
                case 59
                    idx_o = 91291;
                    punc_o = 0;
                case 60
                    idx_o = 115915;
                    punc_o = 0;
                case 61
                    idx_o = 140539;
                    punc_o = 0;
                case 62
                    idx_o = 165163;
                    punc_o = 0;
                case 63
                    idx_o = 189787;
                    punc_o = 0;
                case 64
                    idx_o = 21008;
                    punc_o = 0;
                case 65
                    idx_o = 45632;
                    punc_o = 0;
                case 66
                    idx_o = 70256;
                    punc_o = 0;
                case 67
                    idx_o = 94880;
                    punc_o = 0;
                case 68
                    idx_o = 119504;
                    punc_o = 0;
                case 69
                    idx_o = 144128;
                    punc_o = 0;
                case 70
                    idx_o = 168752;
                    punc_o = 0;
                case 71
                    idx_o = 193376;
                    punc_o = 0;
                case 72
                    idx_o = 20497;
                    punc_o = 0;
                case 73
                    idx_o = 45121;
                    punc_o = 0;
                case 74
                    idx_o = 69745;
                    punc_o = 0;
                case 75
                    idx_o = 94369;
                    punc_o = 0;
                case 76
                    idx_o = 118993;
                    punc_o = 0;
                case 77
                    idx_o = 143617;
                    punc_o = 0;
                case 78
                    idx_o = 168241;
                    punc_o = 0;
                case 79
                    idx_o = 192865;
                    punc_o = 0;
                case 80
                    idx_o = 22034;
                    punc_o = 0;
                case 81
                    idx_o = 46658;
                    punc_o = 0;
                case 82
                    idx_o = 71282;
                    punc_o = 0;
                case 83
                    idx_o = 95906;
                    punc_o = 0;
                case 84
                    idx_o = 120530;
                    punc_o = 0;
                case 85
                    idx_o = 145154;
                    punc_o = 0;
                case 86
                    idx_o = 169778;
                    punc_o = 0;
                case 87
                    idx_o = 194402;
                    punc_o = 0;
                case 88
                    idx_o = 21523;
                    punc_o = 0;
                case 89
                    idx_o = 46147;
                    punc_o = 0;
                case 90
                    idx_o = 70771;
                    punc_o = 0;
                case 91
                    idx_o = 95395;
                    punc_o = 0;
                case 92
                    idx_o = 120019;
                    punc_o = 0;
                case 93
                    idx_o = 144643;
                    punc_o = 0;
                case 94
                    idx_o = 169267;
                    punc_o = 0;
                case 95
                    idx_o = 193891;
                    punc_o = 0;
            end
        case 10
            switch idx_i
                case 0
                    idx_o = 12288;
                    punc_o = 0;
                case 1
                    idx_o = 36912;
                    punc_o = 0;
                case 2
                    idx_o = 61536;
                    punc_o = 0;
                case 3
                    idx_o = 86160;
                    punc_o = 0;
                case 4
                    idx_o = 110784;
                    punc_o = 0;
                case 5
                    idx_o = 135408;
                    punc_o = 0;
                case 6
                    idx_o = 160032;
                    punc_o = 0;
                case 7
                    idx_o = 184656;
                    punc_o = 0;
                case 8
                    idx_o = 12801;
                    punc_o = 0;
                case 9
                    idx_o = 37425;
                    punc_o = 0;
                case 10
                    idx_o = 62049;
                    punc_o = 0;
                case 11
                    idx_o = 86673;
                    punc_o = 0;
                case 12
                    idx_o = 111297;
                    punc_o = 0;
                case 13
                    idx_o = 135921;
                    punc_o = 0;
                case 14
                    idx_o = 160545;
                    punc_o = 0;
                case 15
                    idx_o = 185169;
                    punc_o = 0;
                case 16
                    idx_o = 16392;
                    punc_o = 0;
                case 17
                    idx_o = 41016;
                    punc_o = 0;
                case 18
                    idx_o = 65640;
                    punc_o = 0;
                case 19
                    idx_o = 90264;
                    punc_o = 0;
                case 20
                    idx_o = 114888;
                    punc_o = 0;
                case 21
                    idx_o = 139512;
                    punc_o = 0;
                case 22
                    idx_o = 164136;
                    punc_o = 0;
                case 23
                    idx_o = 188760;
                    punc_o = 0;
                case 24
                    idx_o = 16905;
                    punc_o = 0;
                case 25
                    idx_o = 41529;
                    punc_o = 0;
                case 26
                    idx_o = 66153;
                    punc_o = 0;
                case 27
                    idx_o = 90777;
                    punc_o = 0;
                case 28
                    idx_o = 115401;
                    punc_o = 0;
                case 29
                    idx_o = 140025;
                    punc_o = 0;
                case 30
                    idx_o = 164649;
                    punc_o = 0;
                case 31
                    idx_o = 189273;
                    punc_o = 0;
                case 32
                    idx_o = 20496;
                    punc_o = 0;
                case 33
                    idx_o = 45120;
                    punc_o = 0;
                case 34
                    idx_o = 69744;
                    punc_o = 0;
                case 35
                    idx_o = 94368;
                    punc_o = 0;
                case 36
                    idx_o = 118992;
                    punc_o = 0;
                case 37
                    idx_o = 143616;
                    punc_o = 0;
                case 38
                    idx_o = 168240;
                    punc_o = 0;
                case 39
                    idx_o = 192864;
                    punc_o = 0;
                case 40
                    idx_o = 21009;
                    punc_o = 0;
                case 41
                    idx_o = 45633;
                    punc_o = 0;
                case 42
                    idx_o = 70257;
                    punc_o = 0;
                case 43
                    idx_o = 94881;
                    punc_o = 0;
                case 44
                    idx_o = 119505;
                    punc_o = 0;
                case 45
                    idx_o = 144129;
                    punc_o = 0;
                case 46
                    idx_o = 168753;
                    punc_o = 0;
                case 47
                    idx_o = 193377;
                    punc_o = 0;
            end
        case 11
            switch idx_i
                case 0
                    idx_o = 12288;
                    punc_o = 0;
                case 1
                    idx_o = 36912;
                    punc_o = 0;
                case 2
                    idx_o = 61536;
                    punc_o = 0;
                case 3
                    idx_o = 86160;
                    punc_o = 0;
                case 4
                    idx_o = 110784;
                    punc_o = 0;
                case 5
                    idx_o = 135408;
                    punc_o = 0;
                case 6
                    idx_o = 160032;
                    punc_o = 0;
                case 7
                    idx_o = 184656;
                    punc_o = 0;
                case 8
                    idx_o = 16392;
                    punc_o = 0;
                case 9
                    idx_o = 41016;
                    punc_o = 0;
                case 10
                    idx_o = 65640;
                    punc_o = 0;
                case 11
                    idx_o = 90264;
                    punc_o = 0;
                case 12
                    idx_o = 114888;
                    punc_o = 0;
                case 13
                    idx_o = 139512;
                    punc_o = 0;
                case 14
                    idx_o = 164136;
                    punc_o = 0;
                case 15
                    idx_o = 188760;
                    punc_o = 0;
                case 16
                    idx_o = 20496;
                    punc_o = 0;
                case 17
                    idx_o = 45120;
                    punc_o = 0;
                case 18
                    idx_o = 69744;
                    punc_o = 0;
                case 19
                    idx_o = 94368;
                    punc_o = 0;
                case 20
                    idx_o = 118992;
                    punc_o = 0;
                case 21
                    idx_o = 143616;
                    punc_o = 0;
                case 22
                    idx_o = 168240;
                    punc_o = 0;
                case 23
                    idx_o = 192864;
                    punc_o = 0;
            end
        case 12
            switch idx_i
                case 0
                    idx_o = 13312;
                    punc_o = 0;
                case 1
                    idx_o = 261681;
                    punc_o = 2;
                case 2
                    idx_o = 37375;
                    punc_o = 1;
                case 3
                    idx_o = 62050;
                    punc_o = 0;
                case 4
                    idx_o = 261776;
                    punc_o = 2;
                case 5
                    idx_o = 87551;
                    punc_o = 1;
                case 6
                    idx_o = 110785;
                    punc_o = 0;
                case 7
                    idx_o = 261874;
                    punc_o = 2;
                case 8
                    idx_o = 136191;
                    punc_o = 1;
                case 9
                    idx_o = 161056;
                    punc_o = 0;
                case 10
                    idx_o = 261969;
                    punc_o = 2;
                case 11
                    idx_o = 184831;
                    punc_o = 1;
                case 12
                    idx_o = 12289;
                    punc_o = 0;
                case 13
                    idx_o = 261682;
                    punc_o = 2;
                case 14
                    idx_o = 37887;
                    punc_o = 1;
                case 15
                    idx_o = 62560;
                    punc_o = 0;
                case 16
                    idx_o = 261777;
                    punc_o = 2;
                case 17
                    idx_o = 86527;
                    punc_o = 1;
                case 18
                    idx_o = 111298;
                    punc_o = 0;
                case 19
                    idx_o = 261872;
                    punc_o = 2;
                case 20
                    idx_o = 136703;
                    punc_o = 1;
                case 21
                    idx_o = 160033;
                    punc_o = 0;
                case 22
                    idx_o = 261970;
                    punc_o = 2;
                case 23
                    idx_o = 185343;
                    punc_o = 1;
                case 24
                    idx_o = 12802;
                    punc_o = 0;
                case 25
                    idx_o = 261680;
                    punc_o = 2;
                case 26
                    idx_o = 38399;
                    punc_o = 1;
                case 27
                    idx_o = 61537;
                    punc_o = 0;
                case 28
                    idx_o = 261778;
                    punc_o = 2;
                case 29
                    idx_o = 87039;
                    punc_o = 1;
                case 30
                    idx_o = 111808;
                    punc_o = 0;
                case 31
                    idx_o = 261873;
                    punc_o = 2;
                case 32
                    idx_o = 135679;
                    punc_o = 1;
                case 33
                    idx_o = 160546;
                    punc_o = 0;
                case 34
                    idx_o = 261968;
                    punc_o = 2;
                case 35
                    idx_o = 185855;
                    punc_o = 1;
                case 36
                    idx_o = 14851;
                    punc_o = 0;
                case 37
                    idx_o = 261684;
                    punc_o = 2;
                case 38
                    idx_o = 38911;
                    punc_o = 1;
                case 39
                    idx_o = 63589;
                    punc_o = 0;
                case 40
                    idx_o = 261779;
                    punc_o = 2;
                case 41
                    idx_o = 89087;
                    punc_o = 1;
                case 42
                    idx_o = 112324;
                    punc_o = 0;
                case 43
                    idx_o = 261877;
                    punc_o = 2;
                case 44
                    idx_o = 137727;
                    punc_o = 1;
                case 45
                    idx_o = 162595;
                    punc_o = 0;
                case 46
                    idx_o = 261972;
                    punc_o = 2;
                case 47
                    idx_o = 186367;
                    punc_o = 1;
                case 48
                    idx_o = 13828;
                    punc_o = 0;
                case 49
                    idx_o = 261685;
                    punc_o = 2;
                case 50
                    idx_o = 39423;
                    punc_o = 1;
                case 51
                    idx_o = 64099;
                    punc_o = 0;
                case 52
                    idx_o = 261780;
                    punc_o = 2;
                case 53
                    idx_o = 88063;
                    punc_o = 1;
                case 54
                    idx_o = 112837;
                    punc_o = 0;
                case 55
                    idx_o = 261875;
                    punc_o = 2;
                case 56
                    idx_o = 138239;
                    punc_o = 1;
                case 57
                    idx_o = 161572;
                    punc_o = 0;
                case 58
                    idx_o = 261973;
                    punc_o = 2;
                case 59
                    idx_o = 186879;
                    punc_o = 1;
                case 60
                    idx_o = 14341;
                    punc_o = 0;
                case 61
                    idx_o = 261683;
                    punc_o = 2;
                case 62
                    idx_o = 39935;
                    punc_o = 1;
                case 63
                    idx_o = 63076;
                    punc_o = 0;
                case 64
                    idx_o = 261781;
                    punc_o = 2;
                case 65
                    idx_o = 88575;
                    punc_o = 1;
                case 66
                    idx_o = 113347;
                    punc_o = 0;
                case 67
                    idx_o = 261876;
                    punc_o = 2;
                case 68
                    idx_o = 137215;
                    punc_o = 1;
                case 69
                    idx_o = 162085;
                    punc_o = 0;
                case 70
                    idx_o = 261971;
                    punc_o = 2;
                case 71
                    idx_o = 187391;
                    punc_o = 1;
                case 72
                    idx_o = 17416;
                    punc_o = 0;
                case 73
                    idx_o = 261689;
                    punc_o = 2;
                case 74
                    idx_o = 41471;
                    punc_o = 1;
                case 75
                    idx_o = 66154;
                    punc_o = 0;
                case 76
                    idx_o = 261784;
                    punc_o = 2;
                case 77
                    idx_o = 91647;
                    punc_o = 1;
                case 78
                    idx_o = 114889;
                    punc_o = 0;
                case 79
                    idx_o = 261882;
                    punc_o = 2;
                case 80
                    idx_o = 140287;
                    punc_o = 1;
                case 81
                    idx_o = 165160;
                    punc_o = 0;
                case 82
                    idx_o = 261977;
                    punc_o = 2;
                case 83
                    idx_o = 188927;
                    punc_o = 1;
                case 84
                    idx_o = 16393;
                    punc_o = 0;
                case 85
                    idx_o = 261690;
                    punc_o = 2;
                case 86
                    idx_o = 41983;
                    punc_o = 1;
                case 87
                    idx_o = 66664;
                    punc_o = 0;
                case 88
                    idx_o = 261785;
                    punc_o = 2;
                case 89
                    idx_o = 90623;
                    punc_o = 1;
                case 90
                    idx_o = 115402;
                    punc_o = 0;
                case 91
                    idx_o = 261880;
                    punc_o = 2;
                case 92
                    idx_o = 140799;
                    punc_o = 1;
                case 93
                    idx_o = 164137;
                    punc_o = 0;
                case 94
                    idx_o = 261978;
                    punc_o = 2;
                case 95
                    idx_o = 189439;
                    punc_o = 1;
                case 96
                    idx_o = 16906;
                    punc_o = 0;
                case 97
                    idx_o = 261688;
                    punc_o = 2;
                case 98
                    idx_o = 42495;
                    punc_o = 1;
                case 99
                    idx_o = 65641;
                    punc_o = 0;
                case 100
                    idx_o = 261786;
                    punc_o = 2;
                case 101
                    idx_o = 91135;
                    punc_o = 1;
                case 102
                    idx_o = 115912;
                    punc_o = 0;
                case 103
                    idx_o = 261881;
                    punc_o = 2;
                case 104
                    idx_o = 139775;
                    punc_o = 1;
                case 105
                    idx_o = 164650;
                    punc_o = 0;
                case 106
                    idx_o = 261976;
                    punc_o = 2;
                case 107
                    idx_o = 189951;
                    punc_o = 1;
                case 108
                    idx_o = 18955;
                    punc_o = 0;
                case 109
                    idx_o = 261692;
                    punc_o = 2;
                case 110
                    idx_o = 43007;
                    punc_o = 1;
                case 111
                    idx_o = 67693;
                    punc_o = 0;
                case 112
                    idx_o = 261787;
                    punc_o = 2;
                case 113
                    idx_o = 93183;
                    punc_o = 1;
                case 114
                    idx_o = 116428;
                    punc_o = 0;
                case 115
                    idx_o = 261885;
                    punc_o = 2;
                case 116
                    idx_o = 141823;
                    punc_o = 1;
                case 117
                    idx_o = 166699;
                    punc_o = 0;
                case 118
                    idx_o = 261980;
                    punc_o = 2;
                case 119
                    idx_o = 190463;
                    punc_o = 1;
                case 120
                    idx_o = 17932;
                    punc_o = 0;
                case 121
                    idx_o = 261693;
                    punc_o = 2;
                case 122
                    idx_o = 43519;
                    punc_o = 1;
                case 123
                    idx_o = 68203;
                    punc_o = 0;
                case 124
                    idx_o = 261788;
                    punc_o = 2;
                case 125
                    idx_o = 92159;
                    punc_o = 1;
                case 126
                    idx_o = 116941;
                    punc_o = 0;
                case 127
                    idx_o = 261883;
                    punc_o = 2;
                case 128
                    idx_o = 142335;
                    punc_o = 1;
                case 129
                    idx_o = 165676;
                    punc_o = 0;
                case 130
                    idx_o = 261981;
                    punc_o = 2;
                case 131
                    idx_o = 190975;
                    punc_o = 1;
                case 132
                    idx_o = 18445;
                    punc_o = 0;
                case 133
                    idx_o = 261691;
                    punc_o = 2;
                case 134
                    idx_o = 44031;
                    punc_o = 1;
                case 135
                    idx_o = 67180;
                    punc_o = 0;
                case 136
                    idx_o = 261789;
                    punc_o = 2;
                case 137
                    idx_o = 92671;
                    punc_o = 1;
                case 138
                    idx_o = 117451;
                    punc_o = 0;
                case 139
                    idx_o = 261884;
                    punc_o = 2;
                case 140
                    idx_o = 141311;
                    punc_o = 1;
                case 141
                    idx_o = 166189;
                    punc_o = 0;
                case 142
                    idx_o = 261979;
                    punc_o = 2;
                case 143
                    idx_o = 191487;
                    punc_o = 1;
                case 144
                    idx_o = 21520;
                    punc_o = 0;
                case 145
                    idx_o = 261697;
                    punc_o = 2;
                case 146
                    idx_o = 45567;
                    punc_o = 1;
                case 147
                    idx_o = 70258;
                    punc_o = 0;
                case 148
                    idx_o = 261792;
                    punc_o = 2;
                case 149
                    idx_o = 95743;
                    punc_o = 1;
                case 150
                    idx_o = 118993;
                    punc_o = 0;
                case 151
                    idx_o = 261890;
                    punc_o = 2;
                case 152
                    idx_o = 144383;
                    punc_o = 1;
                case 153
                    idx_o = 169264;
                    punc_o = 0;
                case 154
                    idx_o = 261985;
                    punc_o = 2;
                case 155
                    idx_o = 193023;
                    punc_o = 1;
                case 156
                    idx_o = 20497;
                    punc_o = 0;
                case 157
                    idx_o = 261698;
                    punc_o = 2;
                case 158
                    idx_o = 46079;
                    punc_o = 1;
                case 159
                    idx_o = 70768;
                    punc_o = 0;
                case 160
                    idx_o = 261793;
                    punc_o = 2;
                case 161
                    idx_o = 94719;
                    punc_o = 1;
                case 162
                    idx_o = 119506;
                    punc_o = 0;
                case 163
                    idx_o = 261888;
                    punc_o = 2;
                case 164
                    idx_o = 144895;
                    punc_o = 1;
                case 165
                    idx_o = 168241;
                    punc_o = 0;
                case 166
                    idx_o = 261986;
                    punc_o = 2;
                case 167
                    idx_o = 193535;
                    punc_o = 1;
                case 168
                    idx_o = 21010;
                    punc_o = 0;
                case 169
                    idx_o = 261696;
                    punc_o = 2;
                case 170
                    idx_o = 46591;
                    punc_o = 1;
                case 171
                    idx_o = 69745;
                    punc_o = 0;
                case 172
                    idx_o = 261794;
                    punc_o = 2;
                case 173
                    idx_o = 95231;
                    punc_o = 1;
                case 174
                    idx_o = 120016;
                    punc_o = 0;
                case 175
                    idx_o = 261889;
                    punc_o = 2;
                case 176
                    idx_o = 143871;
                    punc_o = 1;
                case 177
                    idx_o = 168754;
                    punc_o = 0;
                case 178
                    idx_o = 261984;
                    punc_o = 2;
                case 179
                    idx_o = 194047;
                    punc_o = 1;
                case 180
                    idx_o = 23059;
                    punc_o = 0;
                case 181
                    idx_o = 261700;
                    punc_o = 2;
                case 182
                    idx_o = 47103;
                    punc_o = 1;
                case 183
                    idx_o = 71797;
                    punc_o = 0;
                case 184
                    idx_o = 261795;
                    punc_o = 2;
                case 185
                    idx_o = 97279;
                    punc_o = 1;
                case 186
                    idx_o = 120532;
                    punc_o = 0;
                case 187
                    idx_o = 261893;
                    punc_o = 2;
                case 188
                    idx_o = 145919;
                    punc_o = 1;
                case 189
                    idx_o = 170803;
                    punc_o = 0;
                case 190
                    idx_o = 261988;
                    punc_o = 2;
                case 191
                    idx_o = 194559;
                    punc_o = 1;
                case 192
                    idx_o = 22036;
                    punc_o = 0;
                case 193
                    idx_o = 261701;
                    punc_o = 2;
                case 194
                    idx_o = 47615;
                    punc_o = 1;
                case 195
                    idx_o = 72307;
                    punc_o = 0;
                case 196
                    idx_o = 261796;
                    punc_o = 2;
                case 197
                    idx_o = 96255;
                    punc_o = 1;
                case 198
                    idx_o = 121045;
                    punc_o = 0;
                case 199
                    idx_o = 261891;
                    punc_o = 2;
                case 200
                    idx_o = 146431;
                    punc_o = 1;
                case 201
                    idx_o = 169780;
                    punc_o = 0;
                case 202
                    idx_o = 261989;
                    punc_o = 2;
                case 203
                    idx_o = 195071;
                    punc_o = 1;
                case 204
                    idx_o = 22549;
                    punc_o = 0;
                case 205
                    idx_o = 261699;
                    punc_o = 2;
                case 206
                    idx_o = 48127;
                    punc_o = 1;
                case 207
                    idx_o = 71284;
                    punc_o = 0;
                case 208
                    idx_o = 261797;
                    punc_o = 2;
                case 209
                    idx_o = 96767;
                    punc_o = 1;
                case 210
                    idx_o = 121555;
                    punc_o = 0;
                case 211
                    idx_o = 261892;
                    punc_o = 2;
                case 212
                    idx_o = 145407;
                    punc_o = 1;
                case 213
                    idx_o = 170293;
                    punc_o = 0;
                case 214
                    idx_o = 261987;
                    punc_o = 2;
                case 215
                    idx_o = 195583;
                    punc_o = 1;
            end
        case 13
            switch idx_i
                case 0
                    idx_o = 12800;
                    punc_o = 0;
                case 1
                    idx_o = 261680;
                    punc_o = 2;
                case 2
                    idx_o = 37887;
                    punc_o = 1;
                case 3
                    idx_o = 62048;
                    punc_o = 0;
                case 4
                    idx_o = 261776;
                    punc_o = 2;
                case 5
                    idx_o = 87039;
                    punc_o = 1;
                case 6
                    idx_o = 111296;
                    punc_o = 0;
                case 7
                    idx_o = 261872;
                    punc_o = 2;
                case 8
                    idx_o = 136191;
                    punc_o = 1;
                case 9
                    idx_o = 160544;
                    punc_o = 0;
                case 10
                    idx_o = 261968;
                    punc_o = 2;
                case 11
                    idx_o = 185343;
                    punc_o = 1;
                case 12
                    idx_o = 12289;
                    punc_o = 0;
                case 13
                    idx_o = 261681;
                    punc_o = 2;
                case 14
                    idx_o = 37375;
                    punc_o = 1;
                case 15
                    idx_o = 61537;
                    punc_o = 0;
                case 16
                    idx_o = 261777;
                    punc_o = 2;
                case 17
                    idx_o = 86527;
                    punc_o = 1;
                case 18
                    idx_o = 110785;
                    punc_o = 0;
                case 19
                    idx_o = 261873;
                    punc_o = 2;
                case 20
                    idx_o = 135679;
                    punc_o = 1;
                case 21
                    idx_o = 160033;
                    punc_o = 0;
                case 22
                    idx_o = 261969;
                    punc_o = 2;
                case 23
                    idx_o = 184831;
                    punc_o = 1;
                case 24
                    idx_o = 13826;
                    punc_o = 0;
                case 25
                    idx_o = 261682;
                    punc_o = 2;
                case 26
                    idx_o = 38911;
                    punc_o = 1;
                case 27
                    idx_o = 63074;
                    punc_o = 0;
                case 28
                    idx_o = 261778;
                    punc_o = 2;
                case 29
                    idx_o = 88063;
                    punc_o = 1;
                case 30
                    idx_o = 112322;
                    punc_o = 0;
                case 31
                    idx_o = 261874;
                    punc_o = 2;
                case 32
                    idx_o = 137215;
                    punc_o = 1;
                case 33
                    idx_o = 161570;
                    punc_o = 0;
                case 34
                    idx_o = 261970;
                    punc_o = 2;
                case 35
                    idx_o = 186367;
                    punc_o = 1;
                case 36
                    idx_o = 13315;
                    punc_o = 0;
                case 37
                    idx_o = 261683;
                    punc_o = 2;
                case 38
                    idx_o = 38399;
                    punc_o = 1;
                case 39
                    idx_o = 62563;
                    punc_o = 0;
                case 40
                    idx_o = 261779;
                    punc_o = 2;
                case 41
                    idx_o = 87551;
                    punc_o = 1;
                case 42
                    idx_o = 111811;
                    punc_o = 0;
                case 43
                    idx_o = 261875;
                    punc_o = 2;
                case 44
                    idx_o = 136703;
                    punc_o = 1;
                case 45
                    idx_o = 161059;
                    punc_o = 0;
                case 46
                    idx_o = 261971;
                    punc_o = 2;
                case 47
                    idx_o = 185855;
                    punc_o = 1;
                case 48
                    idx_o = 16904;
                    punc_o = 0;
                case 49
                    idx_o = 261688;
                    punc_o = 2;
                case 50
                    idx_o = 41983;
                    punc_o = 1;
                case 51
                    idx_o = 66152;
                    punc_o = 0;
                case 52
                    idx_o = 261784;
                    punc_o = 2;
                case 53
                    idx_o = 91135;
                    punc_o = 1;
                case 54
                    idx_o = 115400;
                    punc_o = 0;
                case 55
                    idx_o = 261880;
                    punc_o = 2;
                case 56
                    idx_o = 140287;
                    punc_o = 1;
                case 57
                    idx_o = 164648;
                    punc_o = 0;
                case 58
                    idx_o = 261976;
                    punc_o = 2;
                case 59
                    idx_o = 189439;
                    punc_o = 1;
                case 60
                    idx_o = 16393;
                    punc_o = 0;
                case 61
                    idx_o = 261689;
                    punc_o = 2;
                case 62
                    idx_o = 41471;
                    punc_o = 1;
                case 63
                    idx_o = 65641;
                    punc_o = 0;
                case 64
                    idx_o = 261785;
                    punc_o = 2;
                case 65
                    idx_o = 90623;
                    punc_o = 1;
                case 66
                    idx_o = 114889;
                    punc_o = 0;
                case 67
                    idx_o = 261881;
                    punc_o = 2;
                case 68
                    idx_o = 139775;
                    punc_o = 1;
                case 69
                    idx_o = 164137;
                    punc_o = 0;
                case 70
                    idx_o = 261977;
                    punc_o = 2;
                case 71
                    idx_o = 188927;
                    punc_o = 1;
                case 72
                    idx_o = 17930;
                    punc_o = 0;
                case 73
                    idx_o = 261690;
                    punc_o = 2;
                case 74
                    idx_o = 43007;
                    punc_o = 1;
                case 75
                    idx_o = 67178;
                    punc_o = 0;
                case 76
                    idx_o = 261786;
                    punc_o = 2;
                case 77
                    idx_o = 92159;
                    punc_o = 1;
                case 78
                    idx_o = 116426;
                    punc_o = 0;
                case 79
                    idx_o = 261882;
                    punc_o = 2;
                case 80
                    idx_o = 141311;
                    punc_o = 1;
                case 81
                    idx_o = 165674;
                    punc_o = 0;
                case 82
                    idx_o = 261978;
                    punc_o = 2;
                case 83
                    idx_o = 190463;
                    punc_o = 1;
                case 84
                    idx_o = 17419;
                    punc_o = 0;
                case 85
                    idx_o = 261691;
                    punc_o = 2;
                case 86
                    idx_o = 42495;
                    punc_o = 1;
                case 87
                    idx_o = 66667;
                    punc_o = 0;
                case 88
                    idx_o = 261787;
                    punc_o = 2;
                case 89
                    idx_o = 91647;
                    punc_o = 1;
                case 90
                    idx_o = 115915;
                    punc_o = 0;
                case 91
                    idx_o = 261883;
                    punc_o = 2;
                case 92
                    idx_o = 140799;
                    punc_o = 1;
                case 93
                    idx_o = 165163;
                    punc_o = 0;
                case 94
                    idx_o = 261979;
                    punc_o = 2;
                case 95
                    idx_o = 189951;
                    punc_o = 1;
                case 96
                    idx_o = 21008;
                    punc_o = 0;
                case 97
                    idx_o = 261696;
                    punc_o = 2;
                case 98
                    idx_o = 46079;
                    punc_o = 1;
                case 99
                    idx_o = 70256;
                    punc_o = 0;
                case 100
                    idx_o = 261792;
                    punc_o = 2;
                case 101
                    idx_o = 95231;
                    punc_o = 1;
                case 102
                    idx_o = 119504;
                    punc_o = 0;
                case 103
                    idx_o = 261888;
                    punc_o = 2;
                case 104
                    idx_o = 144383;
                    punc_o = 1;
                case 105
                    idx_o = 168752;
                    punc_o = 0;
                case 106
                    idx_o = 261984;
                    punc_o = 2;
                case 107
                    idx_o = 193535;
                    punc_o = 1;
                case 108
                    idx_o = 20497;
                    punc_o = 0;
                case 109
                    idx_o = 261697;
                    punc_o = 2;
                case 110
                    idx_o = 45567;
                    punc_o = 1;
                case 111
                    idx_o = 69745;
                    punc_o = 0;
                case 112
                    idx_o = 261793;
                    punc_o = 2;
                case 113
                    idx_o = 94719;
                    punc_o = 1;
                case 114
                    idx_o = 118993;
                    punc_o = 0;
                case 115
                    idx_o = 261889;
                    punc_o = 2;
                case 116
                    idx_o = 143871;
                    punc_o = 1;
                case 117
                    idx_o = 168241;
                    punc_o = 0;
                case 118
                    idx_o = 261985;
                    punc_o = 2;
                case 119
                    idx_o = 193023;
                    punc_o = 1;
                case 120
                    idx_o = 22034;
                    punc_o = 0;
                case 121
                    idx_o = 261698;
                    punc_o = 2;
                case 122
                    idx_o = 47103;
                    punc_o = 1;
                case 123
                    idx_o = 71282;
                    punc_o = 0;
                case 124
                    idx_o = 261794;
                    punc_o = 2;
                case 125
                    idx_o = 96255;
                    punc_o = 1;
                case 126
                    idx_o = 120530;
                    punc_o = 0;
                case 127
                    idx_o = 261890;
                    punc_o = 2;
                case 128
                    idx_o = 145407;
                    punc_o = 1;
                case 129
                    idx_o = 169778;
                    punc_o = 0;
                case 130
                    idx_o = 261986;
                    punc_o = 2;
                case 131
                    idx_o = 194559;
                    punc_o = 1;
                case 132
                    idx_o = 21523;
                    punc_o = 0;
                case 133
                    idx_o = 261699;
                    punc_o = 2;
                case 134
                    idx_o = 46591;
                    punc_o = 1;
                case 135
                    idx_o = 70771;
                    punc_o = 0;
                case 136
                    idx_o = 261795;
                    punc_o = 2;
                case 137
                    idx_o = 95743;
                    punc_o = 1;
                case 138
                    idx_o = 120019;
                    punc_o = 0;
                case 139
                    idx_o = 261891;
                    punc_o = 2;
                case 140
                    idx_o = 144895;
                    punc_o = 1;
                case 141
                    idx_o = 169267;
                    punc_o = 0;
                case 142
                    idx_o = 261987;
                    punc_o = 2;
                case 143
                    idx_o = 194047;
                    punc_o = 1;
            end
        case 14
            switch idx_i
                case 0
                    idx_o = 12288;
                    punc_o = 0;
                case 1
                    idx_o = 261680;
                    punc_o = 2;
                case 2
                    idx_o = 37375;
                    punc_o = 1;
                case 3
                    idx_o = 61536;
                    punc_o = 0;
                case 4
                    idx_o = 261776;
                    punc_o = 2;
                case 5
                    idx_o = 86527;
                    punc_o = 1;
                case 6
                    idx_o = 110784;
                    punc_o = 0;
                case 7
                    idx_o = 261872;
                    punc_o = 2;
                case 8
                    idx_o = 135679;
                    punc_o = 1;
                case 9
                    idx_o = 160032;
                    punc_o = 0;
                case 10
                    idx_o = 261968;
                    punc_o = 2;
                case 11
                    idx_o = 184831;
                    punc_o = 1;
                case 12
                    idx_o = 12801;
                    punc_o = 0;
                case 13
                    idx_o = 261681;
                    punc_o = 2;
                case 14
                    idx_o = 37887;
                    punc_o = 1;
                case 15
                    idx_o = 62049;
                    punc_o = 0;
                case 16
                    idx_o = 261777;
                    punc_o = 2;
                case 17
                    idx_o = 87039;
                    punc_o = 1;
                case 18
                    idx_o = 111297;
                    punc_o = 0;
                case 19
                    idx_o = 261873;
                    punc_o = 2;
                case 20
                    idx_o = 136191;
                    punc_o = 1;
                case 21
                    idx_o = 160545;
                    punc_o = 0;
                case 22
                    idx_o = 261969;
                    punc_o = 2;
                case 23
                    idx_o = 185343;
                    punc_o = 1;
                case 24
                    idx_o = 16392;
                    punc_o = 0;
                case 25
                    idx_o = 261688;
                    punc_o = 2;
                case 26
                    idx_o = 41471;
                    punc_o = 1;
                case 27
                    idx_o = 65640;
                    punc_o = 0;
                case 28
                    idx_o = 261784;
                    punc_o = 2;
                case 29
                    idx_o = 90623;
                    punc_o = 1;
                case 30
                    idx_o = 114888;
                    punc_o = 0;
                case 31
                    idx_o = 261880;
                    punc_o = 2;
                case 32
                    idx_o = 139775;
                    punc_o = 1;
                case 33
                    idx_o = 164136;
                    punc_o = 0;
                case 34
                    idx_o = 261976;
                    punc_o = 2;
                case 35
                    idx_o = 188927;
                    punc_o = 1;
                case 36
                    idx_o = 16905;
                    punc_o = 0;
                case 37
                    idx_o = 261689;
                    punc_o = 2;
                case 38
                    idx_o = 41983;
                    punc_o = 1;
                case 39
                    idx_o = 66153;
                    punc_o = 0;
                case 40
                    idx_o = 261785;
                    punc_o = 2;
                case 41
                    idx_o = 91135;
                    punc_o = 1;
                case 42
                    idx_o = 115401;
                    punc_o = 0;
                case 43
                    idx_o = 261881;
                    punc_o = 2;
                case 44
                    idx_o = 140287;
                    punc_o = 1;
                case 45
                    idx_o = 164649;
                    punc_o = 0;
                case 46
                    idx_o = 261977;
                    punc_o = 2;
                case 47
                    idx_o = 189439;
                    punc_o = 1;
                case 48
                    idx_o = 20496;
                    punc_o = 0;
                case 49
                    idx_o = 261696;
                    punc_o = 2;
                case 50
                    idx_o = 45567;
                    punc_o = 1;
                case 51
                    idx_o = 69744;
                    punc_o = 0;
                case 52
                    idx_o = 261792;
                    punc_o = 2;
                case 53
                    idx_o = 94719;
                    punc_o = 1;
                case 54
                    idx_o = 118992;
                    punc_o = 0;
                case 55
                    idx_o = 261888;
                    punc_o = 2;
                case 56
                    idx_o = 143871;
                    punc_o = 1;
                case 57
                    idx_o = 168240;
                    punc_o = 0;
                case 58
                    idx_o = 261984;
                    punc_o = 2;
                case 59
                    idx_o = 193023;
                    punc_o = 1;
                case 60
                    idx_o = 21009;
                    punc_o = 0;
                case 61
                    idx_o = 261697;
                    punc_o = 2;
                case 62
                    idx_o = 46079;
                    punc_o = 1;
                case 63
                    idx_o = 70257;
                    punc_o = 0;
                case 64
                    idx_o = 261793;
                    punc_o = 2;
                case 65
                    idx_o = 95231;
                    punc_o = 1;
                case 66
                    idx_o = 119505;
                    punc_o = 0;
                case 67
                    idx_o = 261889;
                    punc_o = 2;
                case 68
                    idx_o = 144383;
                    punc_o = 1;
                case 69
                    idx_o = 168753;
                    punc_o = 0;
                case 70
                    idx_o = 261985;
                    punc_o = 2;
                case 71
                    idx_o = 193535;
                    punc_o = 1;
            end
        case 15
            switch idx_i
                case 0
                    idx_o = 12288;
                    punc_o = 0;
                case 1
                    idx_o = 261680;
                    punc_o = 2;
                case 2
                    idx_o = 37375;
                    punc_o = 1;
                case 3
                    idx_o = 61536;
                    punc_o = 0;
                case 4
                    idx_o = 261776;
                    punc_o = 2;
                case 5
                    idx_o = 86527;
                    punc_o = 1;
                case 6
                    idx_o = 110784;
                    punc_o = 0;
                case 7
                    idx_o = 261872;
                    punc_o = 2;
                case 8
                    idx_o = 135679;
                    punc_o = 1;
                case 9
                    idx_o = 160032;
                    punc_o = 0;
                case 10
                    idx_o = 261968;
                    punc_o = 2;
                case 11
                    idx_o = 184831;
                    punc_o = 1;
                case 12
                    idx_o = 16392;
                    punc_o = 0;
                case 13
                    idx_o = 261688;
                    punc_o = 2;
                case 14
                    idx_o = 41471;
                    punc_o = 1;
                case 15
                    idx_o = 65640;
                    punc_o = 0;
                case 16
                    idx_o = 261784;
                    punc_o = 2;
                case 17
                    idx_o = 90623;
                    punc_o = 1;
                case 18
                    idx_o = 114888;
                    punc_o = 0;
                case 19
                    idx_o = 261880;
                    punc_o = 2;
                case 20
                    idx_o = 139775;
                    punc_o = 1;
                case 21
                    idx_o = 164136;
                    punc_o = 0;
                case 22
                    idx_o = 261976;
                    punc_o = 2;
                case 23
                    idx_o = 188927;
                    punc_o = 1;
                case 24
                    idx_o = 20496;
                    punc_o = 0;
                case 25
                    idx_o = 261696;
                    punc_o = 2;
                case 26
                    idx_o = 45567;
                    punc_o = 1;
                case 27
                    idx_o = 69744;
                    punc_o = 0;
                case 28
                    idx_o = 261792;
                    punc_o = 2;
                case 29
                    idx_o = 94719;
                    punc_o = 1;
                case 30
                    idx_o = 118992;
                    punc_o = 0;
                case 31
                    idx_o = 261888;
                    punc_o = 2;
                case 32
                    idx_o = 143871;
                    punc_o = 1;
                case 33
                    idx_o = 168240;
                    punc_o = 0;
                case 34
                    idx_o = 261984;
                    punc_o = 2;
                case 35
                    idx_o = 193023;
                    punc_o = 1;
            end
        case 16
            switch idx_i
                case 0
                    idx_o = 16384;
                    punc_o = 0;
                case 1
                    idx_o = 49216;
                    punc_o = 0;
                case 2
                    idx_o = 82048;
                    punc_o = 0;
                case 3
                    idx_o = 114880;
                    punc_o = 0;
                case 4
                    idx_o = 147712;
                    punc_o = 0;
                case 5
                    idx_o = 180544;
                    punc_o = 0;
                case 6
                    idx_o = 4480;
                    punc_o = 0;
                case 7
                    idx_o = 36904;
                    punc_o = 0;
                case 8
                    idx_o = 69736;
                    punc_o = 0;
                case 9
                    idx_o = 102568;
                    punc_o = 0;
                case 10
                    idx_o = 135400;
                    punc_o = 0;
                case 11
                    idx_o = 168232;
                    punc_o = 0;
                case 12
                    idx_o = 201064;
                    punc_o = 0;
                case 13
                    idx_o = 24592;
                    punc_o = 0;
                case 14
                    idx_o = 57424;
                    punc_o = 0;
                case 15
                    idx_o = 90256;
                    punc_o = 0;
                case 16
                    idx_o = 123088;
                    punc_o = 0;
                case 17
                    idx_o = 155920;
                    punc_o = 0;
                case 18
                    idx_o = 188752;
                    punc_o = 0;
                case 19
                    idx_o = 12688;
                    punc_o = 0;
                case 20
                    idx_o = 45112;
                    punc_o = 0;
                case 21
                    idx_o = 77944;
                    punc_o = 0;
                case 22
                    idx_o = 110776;
                    punc_o = 0;
                case 23
                    idx_o = 143608;
                    punc_o = 0;
                case 24
                    idx_o = 176440;
                    punc_o = 0;
                case 25
                    idx_o = 209272;
                    punc_o = 0;
            end
        case 17
            switch idx_i
                case 0
                    idx_o = 16384;
                    punc_o = 0;
                case 1
                    idx_o = 49216;
                    punc_o = 0;
                case 2
                    idx_o = 82048;
                    punc_o = 0;
                case 3
                    idx_o = 114880;
                    punc_o = 0;
                case 4
                    idx_o = 147712;
                    punc_o = 0;
                case 5
                    idx_o = 180544;
                    punc_o = 0;
                case 6
                    idx_o = 896;
                    punc_o = 0;
                case 7
                    idx_o = 33313;
                    punc_o = 0;
                case 8
                    idx_o = 66145;
                    punc_o = 0;
                case 9
                    idx_o = 98977;
                    punc_o = 0;
                case 10
                    idx_o = 131809;
                    punc_o = 0;
                case 11
                    idx_o = 164641;
                    punc_o = 0;
                case 12
                    idx_o = 197473;
                    punc_o = 0;
                case 13
                    idx_o = 20488;
                    punc_o = 0;
                case 14
                    idx_o = 53320;
                    punc_o = 0;
                case 15
                    idx_o = 86152;
                    punc_o = 0;
                case 16
                    idx_o = 118984;
                    punc_o = 0;
                case 17
                    idx_o = 151816;
                    punc_o = 0;
                case 18
                    idx_o = 184648;
                    punc_o = 0;
                case 19
                    idx_o = 5000;
                    punc_o = 0;
                case 20
                    idx_o = 37417;
                    punc_o = 0;
                case 21
                    idx_o = 70249;
                    punc_o = 0;
                case 22
                    idx_o = 103081;
                    punc_o = 0;
                case 23
                    idx_o = 135913;
                    punc_o = 0;
                case 24
                    idx_o = 168745;
                    punc_o = 0;
                case 25
                    idx_o = 201577;
                    punc_o = 0;
                case 26
                    idx_o = 24592;
                    punc_o = 0;
                case 27
                    idx_o = 57424;
                    punc_o = 0;
                case 28
                    idx_o = 90256;
                    punc_o = 0;
                case 29
                    idx_o = 123088;
                    punc_o = 0;
                case 30
                    idx_o = 155920;
                    punc_o = 0;
                case 31
                    idx_o = 188752;
                    punc_o = 0;
                case 32
                    idx_o = 9104;
                    punc_o = 0;
                case 33
                    idx_o = 41521;
                    punc_o = 0;
                case 34
                    idx_o = 74353;
                    punc_o = 0;
                case 35
                    idx_o = 107185;
                    punc_o = 0;
                case 36
                    idx_o = 140017;
                    punc_o = 0;
                case 37
                    idx_o = 172849;
                    punc_o = 0;
                case 38
                    idx_o = 205681;
                    punc_o = 0;
                case 39
                    idx_o = 28696;
                    punc_o = 0;
                case 40
                    idx_o = 61528;
                    punc_o = 0;
                case 41
                    idx_o = 94360;
                    punc_o = 0;
                case 42
                    idx_o = 127192;
                    punc_o = 0;
                case 43
                    idx_o = 160024;
                    punc_o = 0;
                case 44
                    idx_o = 192856;
                    punc_o = 0;
                case 45
                    idx_o = 13208;
                    punc_o = 0;
                case 46
                    idx_o = 45625;
                    punc_o = 0;
                case 47
                    idx_o = 78457;
                    punc_o = 0;
                case 48
                    idx_o = 111289;
                    punc_o = 0;
                case 49
                    idx_o = 144121;
                    punc_o = 0;
                case 50
                    idx_o = 176953;
                    punc_o = 0;
                case 51
                    idx_o = 209785;
                    punc_o = 0;
            end
        case 18
            switch idx_i
                case 0
                    idx_o = 16384;
                    punc_o = 0;
                case 1
                    idx_o = 261696;
                    punc_o = 2;
                case 2
                    idx_o = 49663;
                    punc_o = 1;
                case 3
                    idx_o = 82048;
                    punc_o = 0;
                case 4
                    idx_o = 261824;
                    punc_o = 2;
                case 5
                    idx_o = 115199;
                    punc_o = 1;
                case 6
                    idx_o = 147712;
                    punc_o = 0;
                case 7
                    idx_o = 261952;
                    punc_o = 2;
                case 8
                    idx_o = 180735;
                    punc_o = 1;
                case 9
                    idx_o = 896;
                    punc_o = 0;
                case 10
                    idx_o = 261665;
                    punc_o = 2;
                case 11
                    idx_o = 33791;
                    punc_o = 1;
                case 12
                    idx_o = 66145;
                    punc_o = 0;
                case 13
                    idx_o = 261793;
                    punc_o = 2;
                case 14
                    idx_o = 99327;
                    punc_o = 1;
                case 15
                    idx_o = 131809;
                    punc_o = 0;
                case 16
                    idx_o = 261921;
                    punc_o = 2;
                case 17
                    idx_o = 164863;
                    punc_o = 1;
                case 18
                    idx_o = 197473;
                    punc_o = 0;
                case 19
                    idx_o = 261640;
                    punc_o = 2;
                case 20
                    idx_o = 20991;
                    punc_o = 1;
                case 21
                    idx_o = 53320;
                    punc_o = 0;
                case 22
                    idx_o = 261768;
                    punc_o = 2;
                case 23
                    idx_o = 86527;
                    punc_o = 1;
                case 24
                    idx_o = 118984;
                    punc_o = 0;
                case 25
                    idx_o = 261896;
                    punc_o = 2;
                case 26
                    idx_o = 152063;
                    punc_o = 1;
                case 27
                    idx_o = 184648;
                    punc_o = 0;
                case 28
                    idx_o = 262024;
                    punc_o = 2;
                case 29
                    idx_o = 5119;
                    punc_o = 1;
                case 30
                    idx_o = 37417;
                    punc_o = 0;
                case 31
                    idx_o = 261737;
                    punc_o = 2;
                case 32
                    idx_o = 70655;
                    punc_o = 1;
                case 33
                    idx_o = 103081;
                    punc_o = 0;
                case 34
                    idx_o = 261865;
                    punc_o = 2;
                case 35
                    idx_o = 136191;
                    punc_o = 1;
                case 36
                    idx_o = 168745;
                    punc_o = 0;
                case 37
                    idx_o = 261993;
                    punc_o = 2;
                case 38
                    idx_o = 201727;
                    punc_o = 1;
                case 39
                    idx_o = 24592;
                    punc_o = 0;
                case 40
                    idx_o = 261712;
                    punc_o = 2;
                case 41
                    idx_o = 57855;
                    punc_o = 1;
                case 42
                    idx_o = 90256;
                    punc_o = 0;
                case 43
                    idx_o = 261840;
                    punc_o = 2;
                case 44
                    idx_o = 123391;
                    punc_o = 1;
                case 45
                    idx_o = 155920;
                    punc_o = 0;
                case 46
                    idx_o = 261968;
                    punc_o = 2;
                case 47
                    idx_o = 188927;
                    punc_o = 1;
                case 48
                    idx_o = 9104;
                    punc_o = 0;
                case 49
                    idx_o = 261681;
                    punc_o = 2;
                case 50
                    idx_o = 41983;
                    punc_o = 1;
                case 51
                    idx_o = 74353;
                    punc_o = 0;
                case 52
                    idx_o = 261809;
                    punc_o = 2;
                case 53
                    idx_o = 107519;
                    punc_o = 1;
                case 54
                    idx_o = 140017;
                    punc_o = 0;
                case 55
                    idx_o = 261937;
                    punc_o = 2;
                case 56
                    idx_o = 173055;
                    punc_o = 1;
                case 57
                    idx_o = 205681;
                    punc_o = 0;
                case 58
                    idx_o = 261656;
                    punc_o = 2;
                case 59
                    idx_o = 29183;
                    punc_o = 1;
                case 60
                    idx_o = 61528;
                    punc_o = 0;
                case 61
                    idx_o = 261784;
                    punc_o = 2;
                case 62
                    idx_o = 94719;
                    punc_o = 1;
                case 63
                    idx_o = 127192;
                    punc_o = 0;
                case 64
                    idx_o = 261912;
                    punc_o = 2;
                case 65
                    idx_o = 160255;
                    punc_o = 1;
                case 66
                    idx_o = 192856;
                    punc_o = 0;
                case 67
                    idx_o = 262040;
                    punc_o = 2;
                case 68
                    idx_o = 13311;
                    punc_o = 1;
                case 69
                    idx_o = 45625;
                    punc_o = 0;
                case 70
                    idx_o = 261753;
                    punc_o = 2;
                case 71
                    idx_o = 78847;
                    punc_o = 1;
                case 72
                    idx_o = 111289;
                    punc_o = 0;
                case 73
                    idx_o = 261881;
                    punc_o = 2;
                case 74
                    idx_o = 144383;
                    punc_o = 1;
                case 75
                    idx_o = 176953;
                    punc_o = 0;
                case 76
                    idx_o = 262009;
                    punc_o = 2;
                case 77
                    idx_o = 209919;
                    punc_o = 1;
            end
        case 19
            switch idx_i
                case 0
                    idx_o = 16896;
                    punc_o = 0;
                case 1
                    idx_o = 49728;
                    punc_o = 0;
                case 2
                    idx_o = 82560;
                    punc_o = 0;
                case 3
                    idx_o = 115392;
                    punc_o = 0;
                case 4
                    idx_o = 148224;
                    punc_o = 0;
                case 5
                    idx_o = 181056;
                    punc_o = 0;
                case 6
                    idx_o = 896;
                    punc_o = 0;
                case 7
                    idx_o = 33312;
                    punc_o = 0;
                case 8
                    idx_o = 66144;
                    punc_o = 0;
                case 9
                    idx_o = 98976;
                    punc_o = 0;
                case 10
                    idx_o = 131808;
                    punc_o = 0;
                case 11
                    idx_o = 164640;
                    punc_o = 0;
                case 12
                    idx_o = 197472;
                    punc_o = 0;
                case 13
                    idx_o = 17922;
                    punc_o = 0;
                case 14
                    idx_o = 50754;
                    punc_o = 0;
                case 15
                    idx_o = 83586;
                    punc_o = 0;
                case 16
                    idx_o = 116418;
                    punc_o = 0;
                case 17
                    idx_o = 149250;
                    punc_o = 0;
                case 18
                    idx_o = 182082;
                    punc_o = 0;
                case 19
                    idx_o = 1922;
                    punc_o = 0;
                case 20
                    idx_o = 34338;
                    punc_o = 0;
                case 21
                    idx_o = 67170;
                    punc_o = 0;
                case 22
                    idx_o = 100002;
                    punc_o = 0;
                case 23
                    idx_o = 132834;
                    punc_o = 0;
                case 24
                    idx_o = 165666;
                    punc_o = 0;
                case 25
                    idx_o = 198498;
                    punc_o = 0;
                case 26
                    idx_o = 21000;
                    punc_o = 0;
                case 27
                    idx_o = 53832;
                    punc_o = 0;
                case 28
                    idx_o = 86664;
                    punc_o = 0;
                case 29
                    idx_o = 119496;
                    punc_o = 0;
                case 30
                    idx_o = 152328;
                    punc_o = 0;
                case 31
                    idx_o = 185160;
                    punc_o = 0;
                case 32
                    idx_o = 5000;
                    punc_o = 0;
                case 33
                    idx_o = 37416;
                    punc_o = 0;
                case 34
                    idx_o = 70248;
                    punc_o = 0;
                case 35
                    idx_o = 103080;
                    punc_o = 0;
                case 36
                    idx_o = 135912;
                    punc_o = 0;
                case 37
                    idx_o = 168744;
                    punc_o = 0;
                case 38
                    idx_o = 201576;
                    punc_o = 0;
                case 39
                    idx_o = 22026;
                    punc_o = 0;
                case 40
                    idx_o = 54858;
                    punc_o = 0;
                case 41
                    idx_o = 87690;
                    punc_o = 0;
                case 42
                    idx_o = 120522;
                    punc_o = 0;
                case 43
                    idx_o = 153354;
                    punc_o = 0;
                case 44
                    idx_o = 186186;
                    punc_o = 0;
                case 45
                    idx_o = 6026;
                    punc_o = 0;
                case 46
                    idx_o = 38442;
                    punc_o = 0;
                case 47
                    idx_o = 71274;
                    punc_o = 0;
                case 48
                    idx_o = 104106;
                    punc_o = 0;
                case 49
                    idx_o = 136938;
                    punc_o = 0;
                case 50
                    idx_o = 169770;
                    punc_o = 0;
                case 51
                    idx_o = 202602;
                    punc_o = 0;
                case 52
                    idx_o = 25104;
                    punc_o = 0;
                case 53
                    idx_o = 57936;
                    punc_o = 0;
                case 54
                    idx_o = 90768;
                    punc_o = 0;
                case 55
                    idx_o = 123600;
                    punc_o = 0;
                case 56
                    idx_o = 156432;
                    punc_o = 0;
                case 57
                    idx_o = 189264;
                    punc_o = 0;
                case 58
                    idx_o = 9104;
                    punc_o = 0;
                case 59
                    idx_o = 41520;
                    punc_o = 0;
                case 60
                    idx_o = 74352;
                    punc_o = 0;
                case 61
                    idx_o = 107184;
                    punc_o = 0;
                case 62
                    idx_o = 140016;
                    punc_o = 0;
                case 63
                    idx_o = 172848;
                    punc_o = 0;
                case 64
                    idx_o = 205680;
                    punc_o = 0;
                case 65
                    idx_o = 26130;
                    punc_o = 0;
                case 66
                    idx_o = 58962;
                    punc_o = 0;
                case 67
                    idx_o = 91794;
                    punc_o = 0;
                case 68
                    idx_o = 124626;
                    punc_o = 0;
                case 69
                    idx_o = 157458;
                    punc_o = 0;
                case 70
                    idx_o = 190290;
                    punc_o = 0;
                case 71
                    idx_o = 10130;
                    punc_o = 0;
                case 72
                    idx_o = 42546;
                    punc_o = 0;
                case 73
                    idx_o = 75378;
                    punc_o = 0;
                case 74
                    idx_o = 108210;
                    punc_o = 0;
                case 75
                    idx_o = 141042;
                    punc_o = 0;
                case 76
                    idx_o = 173874;
                    punc_o = 0;
                case 77
                    idx_o = 206706;
                    punc_o = 0;
                case 78
                    idx_o = 29208;
                    punc_o = 0;
                case 79
                    idx_o = 62040;
                    punc_o = 0;
                case 80
                    idx_o = 94872;
                    punc_o = 0;
                case 81
                    idx_o = 127704;
                    punc_o = 0;
                case 82
                    idx_o = 160536;
                    punc_o = 0;
                case 83
                    idx_o = 193368;
                    punc_o = 0;
                case 84
                    idx_o = 13208;
                    punc_o = 0;
                case 85
                    idx_o = 45624;
                    punc_o = 0;
                case 86
                    idx_o = 78456;
                    punc_o = 0;
                case 87
                    idx_o = 111288;
                    punc_o = 0;
                case 88
                    idx_o = 144120;
                    punc_o = 0;
                case 89
                    idx_o = 176952;
                    punc_o = 0;
                case 90
                    idx_o = 209784;
                    punc_o = 0;
                case 91
                    idx_o = 30234;
                    punc_o = 0;
                case 92
                    idx_o = 63066;
                    punc_o = 0;
                case 93
                    idx_o = 95898;
                    punc_o = 0;
                case 94
                    idx_o = 128730;
                    punc_o = 0;
                case 95
                    idx_o = 161562;
                    punc_o = 0;
                case 96
                    idx_o = 194394;
                    punc_o = 0;
                case 97
                    idx_o = 14234;
                    punc_o = 0;
                case 98
                    idx_o = 46650;
                    punc_o = 0;
                case 99
                    idx_o = 79482;
                    punc_o = 0;
                case 100
                    idx_o = 112314;
                    punc_o = 0;
                case 101
                    idx_o = 145146;
                    punc_o = 0;
                case 102
                    idx_o = 177978;
                    punc_o = 0;
                case 103
                    idx_o = 210810;
                    punc_o = 0;
            end
        case 20
            switch idx_i
                case 0
                    idx_o = 16896;
                    punc_o = 0;
                case 1
                    idx_o = 261696;
                    punc_o = 2;
                case 2
                    idx_o = 50175;
                    punc_o = 1;
                case 3
                    idx_o = 82560;
                    punc_o = 0;
                case 4
                    idx_o = 261824;
                    punc_o = 2;
                case 5
                    idx_o = 115711;
                    punc_o = 1;
                case 6
                    idx_o = 148224;
                    punc_o = 0;
                case 7
                    idx_o = 261952;
                    punc_o = 2;
                case 8
                    idx_o = 181247;
                    punc_o = 1;
                case 9
                    idx_o = 896;
                    punc_o = 0;
                case 10
                    idx_o = 261664;
                    punc_o = 2;
                case 11
                    idx_o = 33791;
                    punc_o = 1;
                case 12
                    idx_o = 66144;
                    punc_o = 0;
                case 13
                    idx_o = 261792;
                    punc_o = 2;
                case 14
                    idx_o = 99327;
                    punc_o = 1;
                case 15
                    idx_o = 131808;
                    punc_o = 0;
                case 16
                    idx_o = 261920;
                    punc_o = 2;
                case 17
                    idx_o = 164863;
                    punc_o = 1;
                case 18
                    idx_o = 197472;
                    punc_o = 0;
                case 19
                    idx_o = 261634;
                    punc_o = 2;
                case 20
                    idx_o = 18431;
                    punc_o = 1;
                case 21
                    idx_o = 50754;
                    punc_o = 0;
                case 22
                    idx_o = 261762;
                    punc_o = 2;
                case 23
                    idx_o = 83967;
                    punc_o = 1;
                case 24
                    idx_o = 116418;
                    punc_o = 0;
                case 25
                    idx_o = 261890;
                    punc_o = 2;
                case 26
                    idx_o = 149503;
                    punc_o = 1;
                case 27
                    idx_o = 182082;
                    punc_o = 0;
                case 28
                    idx_o = 262018;
                    punc_o = 2;
                case 29
                    idx_o = 2047;
                    punc_o = 1;
                case 30
                    idx_o = 34338;
                    punc_o = 0;
                case 31
                    idx_o = 261730;
                    punc_o = 2;
                case 32
                    idx_o = 67583;
                    punc_o = 1;
                case 33
                    idx_o = 100002;
                    punc_o = 0;
                case 34
                    idx_o = 261858;
                    punc_o = 2;
                case 35
                    idx_o = 133119;
                    punc_o = 1;
                case 36
                    idx_o = 165666;
                    punc_o = 0;
                case 37
                    idx_o = 261986;
                    punc_o = 2;
                case 38
                    idx_o = 198655;
                    punc_o = 1;
                case 39
                    idx_o = 21000;
                    punc_o = 0;
                case 40
                    idx_o = 261704;
                    punc_o = 2;
                case 41
                    idx_o = 54271;
                    punc_o = 1;
                case 42
                    idx_o = 86664;
                    punc_o = 0;
                case 43
                    idx_o = 261832;
                    punc_o = 2;
                case 44
                    idx_o = 119807;
                    punc_o = 1;
                case 45
                    idx_o = 152328;
                    punc_o = 0;
                case 46
                    idx_o = 261960;
                    punc_o = 2;
                case 47
                    idx_o = 185343;
                    punc_o = 1;
                case 48
                    idx_o = 5000;
                    punc_o = 0;
                case 49
                    idx_o = 261672;
                    punc_o = 2;
                case 50
                    idx_o = 37887;
                    punc_o = 1;
                case 51
                    idx_o = 70248;
                    punc_o = 0;
                case 52
                    idx_o = 261800;
                    punc_o = 2;
                case 53
                    idx_o = 103423;
                    punc_o = 1;
                case 54
                    idx_o = 135912;
                    punc_o = 0;
                case 55
                    idx_o = 261928;
                    punc_o = 2;
                case 56
                    idx_o = 168959;
                    punc_o = 1;
                case 57
                    idx_o = 201576;
                    punc_o = 0;
                case 58
                    idx_o = 261642;
                    punc_o = 2;
                case 59
                    idx_o = 22527;
                    punc_o = 1;
                case 60
                    idx_o = 54858;
                    punc_o = 0;
                case 61
                    idx_o = 261770;
                    punc_o = 2;
                case 62
                    idx_o = 88063;
                    punc_o = 1;
                case 63
                    idx_o = 120522;
                    punc_o = 0;
                case 64
                    idx_o = 261898;
                    punc_o = 2;
                case 65
                    idx_o = 153599;
                    punc_o = 1;
                case 66
                    idx_o = 186186;
                    punc_o = 0;
                case 67
                    idx_o = 262026;
                    punc_o = 2;
                case 68
                    idx_o = 6143;
                    punc_o = 1;
                case 69
                    idx_o = 38442;
                    punc_o = 0;
                case 70
                    idx_o = 261738;
                    punc_o = 2;
                case 71
                    idx_o = 71679;
                    punc_o = 1;
                case 72
                    idx_o = 104106;
                    punc_o = 0;
                case 73
                    idx_o = 261866;
                    punc_o = 2;
                case 74
                    idx_o = 137215;
                    punc_o = 1;
                case 75
                    idx_o = 169770;
                    punc_o = 0;
                case 76
                    idx_o = 261994;
                    punc_o = 2;
                case 77
                    idx_o = 202751;
                    punc_o = 1;
                case 78
                    idx_o = 25104;
                    punc_o = 0;
                case 79
                    idx_o = 261712;
                    punc_o = 2;
                case 80
                    idx_o = 58367;
                    punc_o = 1;
                case 81
                    idx_o = 90768;
                    punc_o = 0;
                case 82
                    idx_o = 261840;
                    punc_o = 2;
                case 83
                    idx_o = 123903;
                    punc_o = 1;
                case 84
                    idx_o = 156432;
                    punc_o = 0;
                case 85
                    idx_o = 261968;
                    punc_o = 2;
                case 86
                    idx_o = 189439;
                    punc_o = 1;
                case 87
                    idx_o = 9104;
                    punc_o = 0;
                case 88
                    idx_o = 261680;
                    punc_o = 2;
                case 89
                    idx_o = 41983;
                    punc_o = 1;
                case 90
                    idx_o = 74352;
                    punc_o = 0;
                case 91
                    idx_o = 261808;
                    punc_o = 2;
                case 92
                    idx_o = 107519;
                    punc_o = 1;
                case 93
                    idx_o = 140016;
                    punc_o = 0;
                case 94
                    idx_o = 261936;
                    punc_o = 2;
                case 95
                    idx_o = 173055;
                    punc_o = 1;
                case 96
                    idx_o = 205680;
                    punc_o = 0;
                case 97
                    idx_o = 261650;
                    punc_o = 2;
                case 98
                    idx_o = 26623;
                    punc_o = 1;
                case 99
                    idx_o = 58962;
                    punc_o = 0;
                case 100
                    idx_o = 261778;
                    punc_o = 2;
                case 101
                    idx_o = 92159;
                    punc_o = 1;
                case 102
                    idx_o = 124626;
                    punc_o = 0;
                case 103
                    idx_o = 261906;
                    punc_o = 2;
                case 104
                    idx_o = 157695;
                    punc_o = 1;
                case 105
                    idx_o = 190290;
                    punc_o = 0;
                case 106
                    idx_o = 262034;
                    punc_o = 2;
                case 107
                    idx_o = 10239;
                    punc_o = 1;
                case 108
                    idx_o = 42546;
                    punc_o = 0;
                case 109
                    idx_o = 261746;
                    punc_o = 2;
                case 110
                    idx_o = 75775;
                    punc_o = 1;
                case 111
                    idx_o = 108210;
                    punc_o = 0;
                case 112
                    idx_o = 261874;
                    punc_o = 2;
                case 113
                    idx_o = 141311;
                    punc_o = 1;
                case 114
                    idx_o = 173874;
                    punc_o = 0;
                case 115
                    idx_o = 262002;
                    punc_o = 2;
                case 116
                    idx_o = 206847;
                    punc_o = 1;
                case 117
                    idx_o = 29208;
                    punc_o = 0;
                case 118
                    idx_o = 261720;
                    punc_o = 2;
                case 119
                    idx_o = 62463;
                    punc_o = 1;
                case 120
                    idx_o = 94872;
                    punc_o = 0;
                case 121
                    idx_o = 261848;
                    punc_o = 2;
                case 122
                    idx_o = 127999;
                    punc_o = 1;
                case 123
                    idx_o = 160536;
                    punc_o = 0;
                case 124
                    idx_o = 261976;
                    punc_o = 2;
                case 125
                    idx_o = 193535;
                    punc_o = 1;
                case 126
                    idx_o = 13208;
                    punc_o = 0;
                case 127
                    idx_o = 261688;
                    punc_o = 2;
                case 128
                    idx_o = 46079;
                    punc_o = 1;
                case 129
                    idx_o = 78456;
                    punc_o = 0;
                case 130
                    idx_o = 261816;
                    punc_o = 2;
                case 131
                    idx_o = 111615;
                    punc_o = 1;
                case 132
                    idx_o = 144120;
                    punc_o = 0;
                case 133
                    idx_o = 261944;
                    punc_o = 2;
                case 134
                    idx_o = 177151;
                    punc_o = 1;
                case 135
                    idx_o = 209784;
                    punc_o = 0;
                case 136
                    idx_o = 261658;
                    punc_o = 2;
                case 137
                    idx_o = 30719;
                    punc_o = 1;
                case 138
                    idx_o = 63066;
                    punc_o = 0;
                case 139
                    idx_o = 261786;
                    punc_o = 2;
                case 140
                    idx_o = 96255;
                    punc_o = 1;
                case 141
                    idx_o = 128730;
                    punc_o = 0;
                case 142
                    idx_o = 261914;
                    punc_o = 2;
                case 143
                    idx_o = 161791;
                    punc_o = 1;
                case 144
                    idx_o = 194394;
                    punc_o = 0;
                case 145
                    idx_o = 262042;
                    punc_o = 2;
                case 146
                    idx_o = 14335;
                    punc_o = 1;
                case 147
                    idx_o = 46650;
                    punc_o = 0;
                case 148
                    idx_o = 261754;
                    punc_o = 2;
                case 149
                    idx_o = 79871;
                    punc_o = 1;
                case 150
                    idx_o = 112314;
                    punc_o = 0;
                case 151
                    idx_o = 261882;
                    punc_o = 2;
                case 152
                    idx_o = 145407;
                    punc_o = 1;
                case 153
                    idx_o = 177978;
                    punc_o = 0;
                case 154
                    idx_o = 262010;
                    punc_o = 2;
                case 155
                    idx_o = 210943;
                    punc_o = 1;
            end
        case 21
            switch idx_i
                case 0
                    idx_o = 17408;
                    punc_o = 0;
                case 1
                    idx_o = 261697;
                    punc_o = 2;
                case 2
                    idx_o = 66656;
                    punc_o = 0;
                case 3
                    idx_o = 261793;
                    punc_o = 2;
                case 4
                    idx_o = 115904;
                    punc_o = 0;
                case 5
                    idx_o = 261889;
                    punc_o = 2;
                case 6
                    idx_o = 165152;
                    punc_o = 0;
                case 7
                    idx_o = 261985;
                    punc_o = 2;
                case 8
                    idx_o = 896;
                    punc_o = 0;
                case 9
                    idx_o = 261664;
                    punc_o = 2;
                case 10
                    idx_o = 49730;
                    punc_o = 0;
                case 11
                    idx_o = 261760;
                    punc_o = 2;
                case 12
                    idx_o = 98978;
                    punc_o = 0;
                case 13
                    idx_o = 261856;
                    punc_o = 2;
                case 14
                    idx_o = 148226;
                    punc_o = 0;
                case 15
                    idx_o = 261952;
                    punc_o = 2;
                case 16
                    idx_o = 197474;
                    punc_o = 0;
                case 17
                    idx_o = 261634;
                    punc_o = 2;
                case 18
                    idx_o = 32801;
                    punc_o = 0;
                case 19
                    idx_o = 261730;
                    punc_o = 2;
                case 20
                    idx_o = 82049;
                    punc_o = 0;
                case 21
                    idx_o = 261826;
                    punc_o = 2;
                case 22
                    idx_o = 131297;
                    punc_o = 0;
                case 23
                    idx_o = 261922;
                    punc_o = 2;
                case 24
                    idx_o = 180545;
                    punc_o = 0;
                case 25
                    idx_o = 262018;
                    punc_o = 2;
                case 26
                    idx_o = 18947;
                    punc_o = 0;
                case 27
                    idx_o = 261700;
                    punc_o = 2;
                case 28
                    idx_o = 68195;
                    punc_o = 0;
                case 29
                    idx_o = 261796;
                    punc_o = 2;
                case 30
                    idx_o = 117443;
                    punc_o = 0;
                case 31
                    idx_o = 261892;
                    punc_o = 2;
                case 32
                    idx_o = 166691;
                    punc_o = 0;
                case 33
                    idx_o = 261988;
                    punc_o = 2;
                case 34
                    idx_o = 2435;
                    punc_o = 0;
                case 35
                    idx_o = 261667;
                    punc_o = 2;
                case 36
                    idx_o = 51269;
                    punc_o = 0;
                case 37
                    idx_o = 261763;
                    punc_o = 2;
                case 38
                    idx_o = 100517;
                    punc_o = 0;
                case 39
                    idx_o = 261859;
                    punc_o = 2;
                case 40
                    idx_o = 149765;
                    punc_o = 0;
                case 41
                    idx_o = 261955;
                    punc_o = 2;
                case 42
                    idx_o = 199013;
                    punc_o = 0;
                case 43
                    idx_o = 261637;
                    punc_o = 2;
                case 44
                    idx_o = 34340;
                    punc_o = 0;
                case 45
                    idx_o = 261733;
                    punc_o = 2;
                case 46
                    idx_o = 83588;
                    punc_o = 0;
                case 47
                    idx_o = 261829;
                    punc_o = 2;
                case 48
                    idx_o = 132836;
                    punc_o = 0;
                case 49
                    idx_o = 261925;
                    punc_o = 2;
                case 50
                    idx_o = 182084;
                    punc_o = 0;
                case 51
                    idx_o = 262021;
                    punc_o = 2;
                case 52
                    idx_o = 21512;
                    punc_o = 0;
                case 53
                    idx_o = 261705;
                    punc_o = 2;
                case 54
                    idx_o = 70760;
                    punc_o = 0;
                case 55
                    idx_o = 261801;
                    punc_o = 2;
                case 56
                    idx_o = 120008;
                    punc_o = 0;
                case 57
                    idx_o = 261897;
                    punc_o = 2;
                case 58
                    idx_o = 169256;
                    punc_o = 0;
                case 59
                    idx_o = 261993;
                    punc_o = 2;
                case 60
                    idx_o = 5000;
                    punc_o = 0;
                case 61
                    idx_o = 261672;
                    punc_o = 2;
                case 62
                    idx_o = 53834;
                    punc_o = 0;
                case 63
                    idx_o = 261768;
                    punc_o = 2;
                case 64
                    idx_o = 103082;
                    punc_o = 0;
                case 65
                    idx_o = 261864;
                    punc_o = 2;
                case 66
                    idx_o = 152330;
                    punc_o = 0;
                case 67
                    idx_o = 261960;
                    punc_o = 2;
                case 68
                    idx_o = 201578;
                    punc_o = 0;
                case 69
                    idx_o = 261642;
                    punc_o = 2;
                case 70
                    idx_o = 36905;
                    punc_o = 0;
                case 71
                    idx_o = 261738;
                    punc_o = 2;
                case 72
                    idx_o = 86153;
                    punc_o = 0;
                case 73
                    idx_o = 261834;
                    punc_o = 2;
                case 74
                    idx_o = 135401;
                    punc_o = 0;
                case 75
                    idx_o = 261930;
                    punc_o = 2;
                case 76
                    idx_o = 184649;
                    punc_o = 0;
                case 77
                    idx_o = 262026;
                    punc_o = 2;
                case 78
                    idx_o = 23051;
                    punc_o = 0;
                case 79
                    idx_o = 261708;
                    punc_o = 2;
                case 80
                    idx_o = 72299;
                    punc_o = 0;
                case 81
                    idx_o = 261804;
                    punc_o = 2;
                case 82
                    idx_o = 121547;
                    punc_o = 0;
                case 83
                    idx_o = 261900;
                    punc_o = 2;
                case 84
                    idx_o = 170795;
                    punc_o = 0;
                case 85
                    idx_o = 261996;
                    punc_o = 2;
                case 86
                    idx_o = 6539;
                    punc_o = 0;
                case 87
                    idx_o = 261675;
                    punc_o = 2;
                case 88
                    idx_o = 55373;
                    punc_o = 0;
                case 89
                    idx_o = 261771;
                    punc_o = 2;
                case 90
                    idx_o = 104621;
                    punc_o = 0;
                case 91
                    idx_o = 261867;
                    punc_o = 2;
                case 92
                    idx_o = 153869;
                    punc_o = 0;
                case 93
                    idx_o = 261963;
                    punc_o = 2;
                case 94
                    idx_o = 203117;
                    punc_o = 0;
                case 95
                    idx_o = 261645;
                    punc_o = 2;
                case 96
                    idx_o = 38444;
                    punc_o = 0;
                case 97
                    idx_o = 261741;
                    punc_o = 2;
                case 98
                    idx_o = 87692;
                    punc_o = 0;
                case 99
                    idx_o = 261837;
                    punc_o = 2;
                case 100
                    idx_o = 136940;
                    punc_o = 0;
                case 101
                    idx_o = 261933;
                    punc_o = 2;
                case 102
                    idx_o = 186188;
                    punc_o = 0;
                case 103
                    idx_o = 262029;
                    punc_o = 2;
                case 104
                    idx_o = 25616;
                    punc_o = 0;
                case 105
                    idx_o = 261713;
                    punc_o = 2;
                case 106
                    idx_o = 74864;
                    punc_o = 0;
                case 107
                    idx_o = 261809;
                    punc_o = 2;
                case 108
                    idx_o = 124112;
                    punc_o = 0;
                case 109
                    idx_o = 261905;
                    punc_o = 2;
                case 110
                    idx_o = 173360;
                    punc_o = 0;
                case 111
                    idx_o = 262001;
                    punc_o = 2;
                case 112
                    idx_o = 9104;
                    punc_o = 0;
                case 113
                    idx_o = 261680;
                    punc_o = 2;
                case 114
                    idx_o = 57938;
                    punc_o = 0;
                case 115
                    idx_o = 261776;
                    punc_o = 2;
                case 116
                    idx_o = 107186;
                    punc_o = 0;
                case 117
                    idx_o = 261872;
                    punc_o = 2;
                case 118
                    idx_o = 156434;
                    punc_o = 0;
                case 119
                    idx_o = 261968;
                    punc_o = 2;
                case 120
                    idx_o = 205682;
                    punc_o = 0;
                case 121
                    idx_o = 261650;
                    punc_o = 2;
                case 122
                    idx_o = 41009;
                    punc_o = 0;
                case 123
                    idx_o = 261746;
                    punc_o = 2;
                case 124
                    idx_o = 90257;
                    punc_o = 0;
                case 125
                    idx_o = 261842;
                    punc_o = 2;
                case 126
                    idx_o = 139505;
                    punc_o = 0;
                case 127
                    idx_o = 261938;
                    punc_o = 2;
                case 128
                    idx_o = 188753;
                    punc_o = 0;
                case 129
                    idx_o = 262034;
                    punc_o = 2;
                case 130
                    idx_o = 27155;
                    punc_o = 0;
                case 131
                    idx_o = 261716;
                    punc_o = 2;
                case 132
                    idx_o = 76403;
                    punc_o = 0;
                case 133
                    idx_o = 261812;
                    punc_o = 2;
                case 134
                    idx_o = 125651;
                    punc_o = 0;
                case 135
                    idx_o = 261908;
                    punc_o = 2;
                case 136
                    idx_o = 174899;
                    punc_o = 0;
                case 137
                    idx_o = 262004;
                    punc_o = 2;
                case 138
                    idx_o = 10643;
                    punc_o = 0;
                case 139
                    idx_o = 261683;
                    punc_o = 2;
                case 140
                    idx_o = 59477;
                    punc_o = 0;
                case 141
                    idx_o = 261779;
                    punc_o = 2;
                case 142
                    idx_o = 108725;
                    punc_o = 0;
                case 143
                    idx_o = 261875;
                    punc_o = 2;
                case 144
                    idx_o = 157973;
                    punc_o = 0;
                case 145
                    idx_o = 261971;
                    punc_o = 2;
                case 146
                    idx_o = 207221;
                    punc_o = 0;
                case 147
                    idx_o = 261653;
                    punc_o = 2;
                case 148
                    idx_o = 42548;
                    punc_o = 0;
                case 149
                    idx_o = 261749;
                    punc_o = 2;
                case 150
                    idx_o = 91796;
                    punc_o = 0;
                case 151
                    idx_o = 261845;
                    punc_o = 2;
                case 152
                    idx_o = 141044;
                    punc_o = 0;
                case 153
                    idx_o = 261941;
                    punc_o = 2;
                case 154
                    idx_o = 190292;
                    punc_o = 0;
                case 155
                    idx_o = 262037;
                    punc_o = 2;
                case 156
                    idx_o = 29720;
                    punc_o = 0;
                case 157
                    idx_o = 261721;
                    punc_o = 2;
                case 158
                    idx_o = 78968;
                    punc_o = 0;
                case 159
                    idx_o = 261817;
                    punc_o = 2;
                case 160
                    idx_o = 128216;
                    punc_o = 0;
                case 161
                    idx_o = 261913;
                    punc_o = 2;
                case 162
                    idx_o = 177464;
                    punc_o = 0;
                case 163
                    idx_o = 262009;
                    punc_o = 2;
                case 164
                    idx_o = 13208;
                    punc_o = 0;
                case 165
                    idx_o = 261688;
                    punc_o = 2;
                case 166
                    idx_o = 62042;
                    punc_o = 0;
                case 167
                    idx_o = 261784;
                    punc_o = 2;
                case 168
                    idx_o = 111290;
                    punc_o = 0;
                case 169
                    idx_o = 261880;
                    punc_o = 2;
                case 170
                    idx_o = 160538;
                    punc_o = 0;
                case 171
                    idx_o = 261976;
                    punc_o = 2;
                case 172
                    idx_o = 209786;
                    punc_o = 0;
                case 173
                    idx_o = 261658;
                    punc_o = 2;
                case 174
                    idx_o = 45113;
                    punc_o = 0;
                case 175
                    idx_o = 261754;
                    punc_o = 2;
                case 176
                    idx_o = 94361;
                    punc_o = 0;
                case 177
                    idx_o = 261850;
                    punc_o = 2;
                case 178
                    idx_o = 143609;
                    punc_o = 0;
                case 179
                    idx_o = 261946;
                    punc_o = 2;
                case 180
                    idx_o = 192857;
                    punc_o = 0;
                case 181
                    idx_o = 262042;
                    punc_o = 2;
                case 182
                    idx_o = 31259;
                    punc_o = 0;
                case 183
                    idx_o = 261724;
                    punc_o = 2;
                case 184
                    idx_o = 80507;
                    punc_o = 0;
                case 185
                    idx_o = 261820;
                    punc_o = 2;
                case 186
                    idx_o = 129755;
                    punc_o = 0;
                case 187
                    idx_o = 261916;
                    punc_o = 2;
                case 188
                    idx_o = 179003;
                    punc_o = 0;
                case 189
                    idx_o = 262012;
                    punc_o = 2;
                case 190
                    idx_o = 14747;
                    punc_o = 0;
                case 191
                    idx_o = 261691;
                    punc_o = 2;
                case 192
                    idx_o = 63581;
                    punc_o = 0;
                case 193
                    idx_o = 261787;
                    punc_o = 2;
                case 194
                    idx_o = 112829;
                    punc_o = 0;
                case 195
                    idx_o = 261883;
                    punc_o = 2;
                case 196
                    idx_o = 162077;
                    punc_o = 0;
                case 197
                    idx_o = 261979;
                    punc_o = 2;
                case 198
                    idx_o = 211325;
                    punc_o = 0;
                case 199
                    idx_o = 261661;
                    punc_o = 2;
                case 200
                    idx_o = 46652;
                    punc_o = 0;
                case 201
                    idx_o = 261757;
                    punc_o = 2;
                case 202
                    idx_o = 95900;
                    punc_o = 0;
                case 203
                    idx_o = 261853;
                    punc_o = 2;
                case 204
                    idx_o = 145148;
                    punc_o = 0;
                case 205
                    idx_o = 261949;
                    punc_o = 2;
                case 206
                    idx_o = 194396;
                    punc_o = 0;
                case 207
                    idx_o = 262045;
                    punc_o = 2;
            end
        case 22
            switch idx_i
                case 0
                    idx_o = 17408;
                    punc_o = 0;
                case 1
                    idx_o = 261697;
                    punc_o = 2;
                case 2
                    idx_o = 49663;
                    punc_o = 1;
                case 3
                    idx_o = 82562;
                    punc_o = 0;
                case 4
                    idx_o = 261824;
                    punc_o = 2;
                case 5
                    idx_o = 116223;
                    punc_o = 1;
                case 6
                    idx_o = 147713;
                    punc_o = 0;
                case 7
                    idx_o = 261954;
                    punc_o = 2;
                case 8
                    idx_o = 181247;
                    punc_o = 1;
                case 9
                    idx_o = 896;
                    punc_o = 0;
                case 10
                    idx_o = 261664;
                    punc_o = 2;
                case 11
                    idx_o = 34303;
                    punc_o = 1;
                case 12
                    idx_o = 65633;
                    punc_o = 0;
                case 13
                    idx_o = 261794;
                    punc_o = 2;
                case 14
                    idx_o = 99327;
                    punc_o = 1;
                case 15
                    idx_o = 132320;
                    punc_o = 0;
                case 16
                    idx_o = 261921;
                    punc_o = 2;
                case 17
                    idx_o = 164351;
                    punc_o = 1;
                case 18
                    idx_o = 197474;
                    punc_o = 0;
                case 19
                    idx_o = 261634;
                    punc_o = 2;
                case 20
                    idx_o = 17407;
                    punc_o = 1;
                case 21
                    idx_o = 50240;
                    punc_o = 0;
                case 22
                    idx_o = 261761;
                    punc_o = 2;
                case 23
                    idx_o = 82431;
                    punc_o = 1;
                case 24
                    idx_o = 115394;
                    punc_o = 0;
                case 25
                    idx_o = 261888;
                    punc_o = 2;
                case 26
                    idx_o = 148991;
                    punc_o = 1;
                case 27
                    idx_o = 180545;
                    punc_o = 0;
                case 28
                    idx_o = 262018;
                    punc_o = 2;
                case 29
                    idx_o = 2047;
                    punc_o = 1;
                case 30
                    idx_o = 34853;
                    punc_o = 0;
                case 31
                    idx_o = 261731;
                    punc_o = 2;
                case 32
                    idx_o = 68607;
                    punc_o = 1;
                case 33
                    idx_o = 100004;
                    punc_o = 0;
                case 34
                    idx_o = 261861;
                    punc_o = 2;
                case 35
                    idx_o = 133631;
                    punc_o = 1;
                case 36
                    idx_o = 166691;
                    punc_o = 0;
                case 37
                    idx_o = 261988;
                    punc_o = 2;
                case 38
                    idx_o = 198655;
                    punc_o = 1;
                case 39
                    idx_o = 17924;
                    punc_o = 0;
                case 40
                    idx_o = 261701;
                    punc_o = 2;
                case 41
                    idx_o = 51711;
                    punc_o = 1;
                case 42
                    idx_o = 84611;
                    punc_o = 0;
                case 43
                    idx_o = 261828;
                    punc_o = 2;
                case 44
                    idx_o = 116735;
                    punc_o = 1;
                case 45
                    idx_o = 149765;
                    punc_o = 0;
                case 46
                    idx_o = 261955;
                    punc_o = 2;
                case 47
                    idx_o = 183295;
                    punc_o = 1;
                case 48
                    idx_o = 2948;
                    punc_o = 0;
                case 49
                    idx_o = 261668;
                    punc_o = 2;
                case 50
                    idx_o = 34815;
                    punc_o = 1;
                case 51
                    idx_o = 67685;
                    punc_o = 0;
                case 52
                    idx_o = 261795;
                    punc_o = 2;
                case 53
                    idx_o = 101375;
                    punc_o = 1;
                case 54
                    idx_o = 132836;
                    punc_o = 0;
                case 55
                    idx_o = 261925;
                    punc_o = 2;
                case 56
                    idx_o = 166399;
                    punc_o = 1;
                case 57
                    idx_o = 199523;
                    punc_o = 0;
                case 58
                    idx_o = 261640;
                    punc_o = 2;
                case 59
                    idx_o = 22015;
                    punc_o = 1;
                case 60
                    idx_o = 53321;
                    punc_o = 0;
                case 61
                    idx_o = 261770;
                    punc_o = 2;
                case 62
                    idx_o = 87039;
                    punc_o = 1;
                case 63
                    idx_o = 120008;
                    punc_o = 0;
                case 64
                    idx_o = 261897;
                    punc_o = 2;
                case 65
                    idx_o = 152063;
                    punc_o = 1;
                case 66
                    idx_o = 185162;
                    punc_o = 0;
                case 67
                    idx_o = 262024;
                    punc_o = 2;
                case 68
                    idx_o = 5119;
                    punc_o = 1;
                case 69
                    idx_o = 37928;
                    punc_o = 0;
                case 70
                    idx_o = 261737;
                    punc_o = 2;
                case 71
                    idx_o = 70143;
                    punc_o = 1;
                case 72
                    idx_o = 103082;
                    punc_o = 0;
                case 73
                    idx_o = 261864;
                    punc_o = 2;
                case 74
                    idx_o = 136703;
                    punc_o = 1;
                case 75
                    idx_o = 168233;
                    punc_o = 0;
                case 76
                    idx_o = 261994;
                    punc_o = 2;
                case 77
                    idx_o = 201727;
                    punc_o = 1;
                case 78
                    idx_o = 21002;
                    punc_o = 0;
                case 79
                    idx_o = 261704;
                    punc_o = 2;
                case 80
                    idx_o = 54783;
                    punc_o = 1;
                case 81
                    idx_o = 86153;
                    punc_o = 0;
                case 82
                    idx_o = 261834;
                    punc_o = 2;
                case 83
                    idx_o = 119807;
                    punc_o = 1;
                case 84
                    idx_o = 152840;
                    punc_o = 0;
                case 85
                    idx_o = 261961;
                    punc_o = 2;
                case 86
                    idx_o = 184831;
                    punc_o = 1;
                case 87
                    idx_o = 6026;
                    punc_o = 0;
                case 88
                    idx_o = 261677;
                    punc_o = 2;
                case 89
                    idx_o = 39423;
                    punc_o = 1;
                case 90
                    idx_o = 72299;
                    punc_o = 0;
                case 91
                    idx_o = 261804;
                    punc_o = 2;
                case 92
                    idx_o = 104447;
                    punc_o = 1;
                case 93
                    idx_o = 137453;
                    punc_o = 0;
                case 94
                    idx_o = 261931;
                    punc_o = 2;
                case 95
                    idx_o = 171007;
                    punc_o = 1;
                case 96
                    idx_o = 202604;
                    punc_o = 0;
                case 97
                    idx_o = 261644;
                    punc_o = 2;
                case 98
                    idx_o = 22527;
                    punc_o = 1;
                case 99
                    idx_o = 55373;
                    punc_o = 0;
                case 100
                    idx_o = 261771;
                    punc_o = 2;
                case 101
                    idx_o = 89087;
                    punc_o = 1;
                case 102
                    idx_o = 120524;
                    punc_o = 0;
                case 103
                    idx_o = 261901;
                    punc_o = 2;
                case 104
                    idx_o = 154111;
                    punc_o = 1;
                case 105
                    idx_o = 187211;
                    punc_o = 0;
                case 106
                    idx_o = 262028;
                    punc_o = 2;
                case 107
                    idx_o = 7167;
                    punc_o = 1;
                case 108
                    idx_o = 38444;
                    punc_o = 0;
                case 109
                    idx_o = 261741;
                    punc_o = 2;
                case 110
                    idx_o = 72191;
                    punc_o = 1;
                case 111
                    idx_o = 105131;
                    punc_o = 0;
                case 112
                    idx_o = 261868;
                    punc_o = 2;
                case 113
                    idx_o = 137215;
                    punc_o = 1;
                case 114
                    idx_o = 170285;
                    punc_o = 0;
                case 115
                    idx_o = 261995;
                    punc_o = 2;
                case 116
                    idx_o = 203775;
                    punc_o = 1;
                case 117
                    idx_o = 25616;
                    punc_o = 0;
                case 118
                    idx_o = 261713;
                    punc_o = 2;
                case 119
                    idx_o = 57855;
                    punc_o = 1;
                case 120
                    idx_o = 90770;
                    punc_o = 0;
                case 121
                    idx_o = 261840;
                    punc_o = 2;
                case 122
                    idx_o = 124415;
                    punc_o = 1;
                case 123
                    idx_o = 155921;
                    punc_o = 0;
                case 124
                    idx_o = 261970;
                    punc_o = 2;
                case 125
                    idx_o = 189439;
                    punc_o = 1;
                case 126
                    idx_o = 9104;
                    punc_o = 0;
                case 127
                    idx_o = 261680;
                    punc_o = 2;
                case 128
                    idx_o = 42495;
                    punc_o = 1;
                case 129
                    idx_o = 73841;
                    punc_o = 0;
                case 130
                    idx_o = 261810;
                    punc_o = 2;
                case 131
                    idx_o = 107519;
                    punc_o = 1;
                case 132
                    idx_o = 140528;
                    punc_o = 0;
                case 133
                    idx_o = 261937;
                    punc_o = 2;
                case 134
                    idx_o = 172543;
                    punc_o = 1;
                case 135
                    idx_o = 205682;
                    punc_o = 0;
                case 136
                    idx_o = 261650;
                    punc_o = 2;
                case 137
                    idx_o = 25599;
                    punc_o = 1;
                case 138
                    idx_o = 58448;
                    punc_o = 0;
                case 139
                    idx_o = 261777;
                    punc_o = 2;
                case 140
                    idx_o = 90623;
                    punc_o = 1;
                case 141
                    idx_o = 123602;
                    punc_o = 0;
                case 142
                    idx_o = 261904;
                    punc_o = 2;
                case 143
                    idx_o = 157183;
                    punc_o = 1;
                case 144
                    idx_o = 188753;
                    punc_o = 0;
                case 145
                    idx_o = 262034;
                    punc_o = 2;
                case 146
                    idx_o = 10239;
                    punc_o = 1;
                case 147
                    idx_o = 43061;
                    punc_o = 0;
                case 148
                    idx_o = 261747;
                    punc_o = 2;
                case 149
                    idx_o = 76799;
                    punc_o = 1;
                case 150
                    idx_o = 108212;
                    punc_o = 0;
                case 151
                    idx_o = 261877;
                    punc_o = 2;
                case 152
                    idx_o = 141823;
                    punc_o = 1;
                case 153
                    idx_o = 174899;
                    punc_o = 0;
                case 154
                    idx_o = 262004;
                    punc_o = 2;
                case 155
                    idx_o = 206847;
                    punc_o = 1;
                case 156
                    idx_o = 26132;
                    punc_o = 0;
                case 157
                    idx_o = 261717;
                    punc_o = 2;
                case 158
                    idx_o = 59903;
                    punc_o = 1;
                case 159
                    idx_o = 92819;
                    punc_o = 0;
                case 160
                    idx_o = 261844;
                    punc_o = 2;
                case 161
                    idx_o = 124927;
                    punc_o = 1;
                case 162
                    idx_o = 157973;
                    punc_o = 0;
                case 163
                    idx_o = 261971;
                    punc_o = 2;
                case 164
                    idx_o = 191487;
                    punc_o = 1;
                case 165
                    idx_o = 11156;
                    punc_o = 0;
                case 166
                    idx_o = 261684;
                    punc_o = 2;
                case 167
                    idx_o = 43007;
                    punc_o = 1;
                case 168
                    idx_o = 75893;
                    punc_o = 0;
                case 169
                    idx_o = 261811;
                    punc_o = 2;
                case 170
                    idx_o = 109567;
                    punc_o = 1;
                case 171
                    idx_o = 141044;
                    punc_o = 0;
                case 172
                    idx_o = 261941;
                    punc_o = 2;
                case 173
                    idx_o = 174591;
                    punc_o = 1;
                case 174
                    idx_o = 207731;
                    punc_o = 0;
                case 175
                    idx_o = 261656;
                    punc_o = 2;
                case 176
                    idx_o = 30207;
                    punc_o = 1;
                case 177
                    idx_o = 61529;
                    punc_o = 0;
                case 178
                    idx_o = 261786;
                    punc_o = 2;
                case 179
                    idx_o = 95231;
                    punc_o = 1;
                case 180
                    idx_o = 128216;
                    punc_o = 0;
                case 181
                    idx_o = 261913;
                    punc_o = 2;
                case 182
                    idx_o = 160255;
                    punc_o = 1;
                case 183
                    idx_o = 193370;
                    punc_o = 0;
                case 184
                    idx_o = 262040;
                    punc_o = 2;
                case 185
                    idx_o = 13311;
                    punc_o = 1;
                case 186
                    idx_o = 46136;
                    punc_o = 0;
                case 187
                    idx_o = 261753;
                    punc_o = 2;
                case 188
                    idx_o = 78335;
                    punc_o = 1;
                case 189
                    idx_o = 111290;
                    punc_o = 0;
                case 190
                    idx_o = 261880;
                    punc_o = 2;
                case 191
                    idx_o = 144895;
                    punc_o = 1;
                case 192
                    idx_o = 176441;
                    punc_o = 0;
                case 193
                    idx_o = 262010;
                    punc_o = 2;
                case 194
                    idx_o = 209919;
                    punc_o = 1;
                case 195
                    idx_o = 29210;
                    punc_o = 0;
                case 196
                    idx_o = 261720;
                    punc_o = 2;
                case 197
                    idx_o = 62975;
                    punc_o = 1;
                case 198
                    idx_o = 94361;
                    punc_o = 0;
                case 199
                    idx_o = 261850;
                    punc_o = 2;
                case 200
                    idx_o = 127999;
                    punc_o = 1;
                case 201
                    idx_o = 161048;
                    punc_o = 0;
                case 202
                    idx_o = 261977;
                    punc_o = 2;
                case 203
                    idx_o = 193023;
                    punc_o = 1;
                case 204
                    idx_o = 14234;
                    punc_o = 0;
                case 205
                    idx_o = 261693;
                    punc_o = 2;
                case 206
                    idx_o = 47615;
                    punc_o = 1;
                case 207
                    idx_o = 80507;
                    punc_o = 0;
                case 208
                    idx_o = 261820;
                    punc_o = 2;
                case 209
                    idx_o = 112639;
                    punc_o = 1;
                case 210
                    idx_o = 145661;
                    punc_o = 0;
                case 211
                    idx_o = 261947;
                    punc_o = 2;
                case 212
                    idx_o = 179199;
                    punc_o = 1;
                case 213
                    idx_o = 210812;
                    punc_o = 0;
                case 214
                    idx_o = 261660;
                    punc_o = 2;
                case 215
                    idx_o = 30719;
                    punc_o = 1;
                case 216
                    idx_o = 63581;
                    punc_o = 0;
                case 217
                    idx_o = 261787;
                    punc_o = 2;
                case 218
                    idx_o = 97279;
                    punc_o = 1;
                case 219
                    idx_o = 128732;
                    punc_o = 0;
                case 220
                    idx_o = 261917;
                    punc_o = 2;
                case 221
                    idx_o = 162303;
                    punc_o = 1;
                case 222
                    idx_o = 195419;
                    punc_o = 0;
                case 223
                    idx_o = 262044;
                    punc_o = 2;
                case 224
                    idx_o = 15359;
                    punc_o = 1;
                case 225
                    idx_o = 46652;
                    punc_o = 0;
                case 226
                    idx_o = 261757;
                    punc_o = 2;
                case 227
                    idx_o = 80383;
                    punc_o = 1;
                case 228
                    idx_o = 113339;
                    punc_o = 0;
                case 229
                    idx_o = 261884;
                    punc_o = 2;
                case 230
                    idx_o = 145407;
                    punc_o = 1;
                case 231
                    idx_o = 178493;
                    punc_o = 0;
                case 232
                    idx_o = 262011;
                    punc_o = 2;
                case 233
                    idx_o = 211967;
                    punc_o = 1;
            end
        case 23
            switch idx_i
                case 0
                    idx_o = 17408;
                    punc_o = 0;
                case 1
                    idx_o = 261697;
                    punc_o = 2;
                case 2
                    idx_o = 49663;
                    punc_o = 1;
                case 3
                    idx_o = 261762;
                    punc_o = 2;
                case 4
                    idx_o = 82943;
                    punc_o = 1;
                case 5
                    idx_o = 115904;
                    punc_o = 0;
                case 6
                    idx_o = 261889;
                    punc_o = 2;
                case 7
                    idx_o = 147967;
                    punc_o = 1;
                case 8
                    idx_o = 261954;
                    punc_o = 2;
                case 9
                    idx_o = 181247;
                    punc_o = 1;
                case 10
                    idx_o = 896;
                    punc_o = 0;
                case 11
                    idx_o = 261664;
                    punc_o = 2;
                case 12
                    idx_o = 34303;
                    punc_o = 1;
                case 13
                    idx_o = 261729;
                    punc_o = 2;
                case 14
                    idx_o = 66047;
                    punc_o = 1;
                case 15
                    idx_o = 98978;
                    punc_o = 0;
                case 16
                    idx_o = 261856;
                    punc_o = 2;
                case 17
                    idx_o = 132607;
                    punc_o = 1;
                case 18
                    idx_o = 261921;
                    punc_o = 2;
                case 19
                    idx_o = 164351;
                    punc_o = 1;
                case 20
                    idx_o = 197474;
                    punc_o = 0;
                case 21
                    idx_o = 261634;
                    punc_o = 2;
                case 22
                    idx_o = 17407;
                    punc_o = 1;
                case 23
                    idx_o = 261696;
                    punc_o = 2;
                case 24
                    idx_o = 50687;
                    punc_o = 1;
                case 25
                    idx_o = 82049;
                    punc_o = 0;
                case 26
                    idx_o = 261826;
                    punc_o = 2;
                case 27
                    idx_o = 115711;
                    punc_o = 1;
                case 28
                    idx_o = 261888;
                    punc_o = 2;
                case 29
                    idx_o = 148991;
                    punc_o = 1;
                case 30
                    idx_o = 180545;
                    punc_o = 0;
                case 31
                    idx_o = 262018;
                    punc_o = 2;
                case 32
                    idx_o = 2047;
                    punc_o = 1;
                case 33
                    idx_o = 261669;
                    punc_o = 2;
                case 34
                    idx_o = 35327;
                    punc_o = 1;
                case 35
                    idx_o = 68195;
                    punc_o = 0;
                case 36
                    idx_o = 261796;
                    punc_o = 2;
                case 37
                    idx_o = 100351;
                    punc_o = 1;
                case 38
                    idx_o = 261861;
                    punc_o = 2;
                case 39
                    idx_o = 133631;
                    punc_o = 1;
                case 40
                    idx_o = 166691;
                    punc_o = 0;
                case 41
                    idx_o = 261988;
                    punc_o = 2;
                case 42
                    idx_o = 198655;
                    punc_o = 1;
                case 43
                    idx_o = 261636;
                    punc_o = 2;
                case 44
                    idx_o = 18431;
                    punc_o = 1;
                case 45
                    idx_o = 51269;
                    punc_o = 0;
                case 46
                    idx_o = 261763;
                    punc_o = 2;
                case 47
                    idx_o = 84991;
                    punc_o = 1;
                case 48
                    idx_o = 261828;
                    punc_o = 2;
                case 49
                    idx_o = 116735;
                    punc_o = 1;
                case 50
                    idx_o = 149765;
                    punc_o = 0;
                case 51
                    idx_o = 261955;
                    punc_o = 2;
                case 52
                    idx_o = 183295;
                    punc_o = 1;
                case 53
                    idx_o = 262020;
                    punc_o = 2;
                case 54
                    idx_o = 3071;
                    punc_o = 1;
                case 55
                    idx_o = 34340;
                    punc_o = 0;
                case 56
                    idx_o = 261733;
                    punc_o = 2;
                case 57
                    idx_o = 68095;
                    punc_o = 1;
                case 58
                    idx_o = 261795;
                    punc_o = 2;
                case 59
                    idx_o = 101375;
                    punc_o = 1;
                case 60
                    idx_o = 132836;
                    punc_o = 0;
                case 61
                    idx_o = 261925;
                    punc_o = 2;
                case 62
                    idx_o = 166399;
                    punc_o = 1;
                case 63
                    idx_o = 261987;
                    punc_o = 2;
                case 64
                    idx_o = 199679;
                    punc_o = 1;
                case 65
                    idx_o = 21512;
                    punc_o = 0;
                case 66
                    idx_o = 261705;
                    punc_o = 2;
                case 67
                    idx_o = 53759;
                    punc_o = 1;
                case 68
                    idx_o = 261770;
                    punc_o = 2;
                case 69
                    idx_o = 87039;
                    punc_o = 1;
                case 70
                    idx_o = 120008;
                    punc_o = 0;
                case 71
                    idx_o = 261897;
                    punc_o = 2;
                case 72
                    idx_o = 152063;
                    punc_o = 1;
                case 73
                    idx_o = 261962;
                    punc_o = 2;
                case 74
                    idx_o = 185343;
                    punc_o = 1;
                case 75
                    idx_o = 5000;
                    punc_o = 0;
                case 76
                    idx_o = 261672;
                    punc_o = 2;
                case 77
                    idx_o = 38399;
                    punc_o = 1;
                case 78
                    idx_o = 261737;
                    punc_o = 2;
                case 79
                    idx_o = 70143;
                    punc_o = 1;
                case 80
                    idx_o = 103082;
                    punc_o = 0;
                case 81
                    idx_o = 261864;
                    punc_o = 2;
                case 82
                    idx_o = 136703;
                    punc_o = 1;
                case 83
                    idx_o = 261929;
                    punc_o = 2;
                case 84
                    idx_o = 168447;
                    punc_o = 1;
                case 85
                    idx_o = 201578;
                    punc_o = 0;
                case 86
                    idx_o = 261642;
                    punc_o = 2;
                case 87
                    idx_o = 21503;
                    punc_o = 1;
                case 88
                    idx_o = 261704;
                    punc_o = 2;
                case 89
                    idx_o = 54783;
                    punc_o = 1;
                case 90
                    idx_o = 86153;
                    punc_o = 0;
                case 91
                    idx_o = 261834;
                    punc_o = 2;
                case 92
                    idx_o = 119807;
                    punc_o = 1;
                case 93
                    idx_o = 261896;
                    punc_o = 2;
                case 94
                    idx_o = 153087;
                    punc_o = 1;
                case 95
                    idx_o = 184649;
                    punc_o = 0;
                case 96
                    idx_o = 262026;
                    punc_o = 2;
                case 97
                    idx_o = 6143;
                    punc_o = 1;
                case 98
                    idx_o = 261677;
                    punc_o = 2;
                case 99
                    idx_o = 39423;
                    punc_o = 1;
                case 100
                    idx_o = 72299;
                    punc_o = 0;
                case 101
                    idx_o = 261804;
                    punc_o = 2;
                case 102
                    idx_o = 104447;
                    punc_o = 1;
                case 103
                    idx_o = 261869;
                    punc_o = 2;
                case 104
                    idx_o = 137727;
                    punc_o = 1;
                case 105
                    idx_o = 170795;
                    punc_o = 0;
                case 106
                    idx_o = 261996;
                    punc_o = 2;
                case 107
                    idx_o = 202751;
                    punc_o = 1;
                case 108
                    idx_o = 261644;
                    punc_o = 2;
                case 109
                    idx_o = 22527;
                    punc_o = 1;
                case 110
                    idx_o = 55373;
                    punc_o = 0;
                case 111
                    idx_o = 261771;
                    punc_o = 2;
                case 112
                    idx_o = 89087;
                    punc_o = 1;
                case 113
                    idx_o = 261836;
                    punc_o = 2;
                case 114
                    idx_o = 120831;
                    punc_o = 1;
                case 115
                    idx_o = 153869;
                    punc_o = 0;
                case 116
                    idx_o = 261963;
                    punc_o = 2;
                case 117
                    idx_o = 187391;
                    punc_o = 1;
                case 118
                    idx_o = 262028;
                    punc_o = 2;
                case 119
                    idx_o = 7167;
                    punc_o = 1;
                case 120
                    idx_o = 38444;
                    punc_o = 0;
                case 121
                    idx_o = 261741;
                    punc_o = 2;
                case 122
                    idx_o = 72191;
                    punc_o = 1;
                case 123
                    idx_o = 261803;
                    punc_o = 2;
                case 124
                    idx_o = 105471;
                    punc_o = 1;
                case 125
                    idx_o = 136940;
                    punc_o = 0;
                case 126
                    idx_o = 261933;
                    punc_o = 2;
                case 127
                    idx_o = 170495;
                    punc_o = 1;
                case 128
                    idx_o = 261995;
                    punc_o = 2;
                case 129
                    idx_o = 203775;
                    punc_o = 1;
                case 130
                    idx_o = 25616;
                    punc_o = 0;
                case 131
                    idx_o = 261713;
                    punc_o = 2;
                case 132
                    idx_o = 57855;
                    punc_o = 1;
                case 133
                    idx_o = 261778;
                    punc_o = 2;
                case 134
                    idx_o = 91135;
                    punc_o = 1;
                case 135
                    idx_o = 124112;
                    punc_o = 0;
                case 136
                    idx_o = 261905;
                    punc_o = 2;
                case 137
                    idx_o = 156159;
                    punc_o = 1;
                case 138
                    idx_o = 261970;
                    punc_o = 2;
                case 139
                    idx_o = 189439;
                    punc_o = 1;
                case 140
                    idx_o = 9104;
                    punc_o = 0;
                case 141
                    idx_o = 261680;
                    punc_o = 2;
                case 142
                    idx_o = 42495;
                    punc_o = 1;
                case 143
                    idx_o = 261745;
                    punc_o = 2;
                case 144
                    idx_o = 74239;
                    punc_o = 1;
                case 145
                    idx_o = 107186;
                    punc_o = 0;
                case 146
                    idx_o = 261872;
                    punc_o = 2;
                case 147
                    idx_o = 140799;
                    punc_o = 1;
                case 148
                    idx_o = 261937;
                    punc_o = 2;
                case 149
                    idx_o = 172543;
                    punc_o = 1;
                case 150
                    idx_o = 205682;
                    punc_o = 0;
                case 151
                    idx_o = 261650;
                    punc_o = 2;
                case 152
                    idx_o = 25599;
                    punc_o = 1;
                case 153
                    idx_o = 261712;
                    punc_o = 2;
                case 154
                    idx_o = 58879;
                    punc_o = 1;
                case 155
                    idx_o = 90257;
                    punc_o = 0;
                case 156
                    idx_o = 261842;
                    punc_o = 2;
                case 157
                    idx_o = 123903;
                    punc_o = 1;
                case 158
                    idx_o = 261904;
                    punc_o = 2;
                case 159
                    idx_o = 157183;
                    punc_o = 1;
                case 160
                    idx_o = 188753;
                    punc_o = 0;
                case 161
                    idx_o = 262034;
                    punc_o = 2;
                case 162
                    idx_o = 10239;
                    punc_o = 1;
                case 163
                    idx_o = 261685;
                    punc_o = 2;
                case 164
                    idx_o = 43519;
                    punc_o = 1;
                case 165
                    idx_o = 76403;
                    punc_o = 0;
                case 166
                    idx_o = 261812;
                    punc_o = 2;
                case 167
                    idx_o = 108543;
                    punc_o = 1;
                case 168
                    idx_o = 261877;
                    punc_o = 2;
                case 169
                    idx_o = 141823;
                    punc_o = 1;
                case 170
                    idx_o = 174899;
                    punc_o = 0;
                case 171
                    idx_o = 262004;
                    punc_o = 2;
                case 172
                    idx_o = 206847;
                    punc_o = 1;
                case 173
                    idx_o = 261652;
                    punc_o = 2;
                case 174
                    idx_o = 26623;
                    punc_o = 1;
                case 175
                    idx_o = 59477;
                    punc_o = 0;
                case 176
                    idx_o = 261779;
                    punc_o = 2;
                case 177
                    idx_o = 93183;
                    punc_o = 1;
                case 178
                    idx_o = 261844;
                    punc_o = 2;
                case 179
                    idx_o = 124927;
                    punc_o = 1;
                case 180
                    idx_o = 157973;
                    punc_o = 0;
                case 181
                    idx_o = 261971;
                    punc_o = 2;
                case 182
                    idx_o = 191487;
                    punc_o = 1;
                case 183
                    idx_o = 262036;
                    punc_o = 2;
                case 184
                    idx_o = 11263;
                    punc_o = 1;
                case 185
                    idx_o = 42548;
                    punc_o = 0;
                case 186
                    idx_o = 261749;
                    punc_o = 2;
                case 187
                    idx_o = 76287;
                    punc_o = 1;
                case 188
                    idx_o = 261811;
                    punc_o = 2;
                case 189
                    idx_o = 109567;
                    punc_o = 1;
                case 190
                    idx_o = 141044;
                    punc_o = 0;
                case 191
                    idx_o = 261941;
                    punc_o = 2;
                case 192
                    idx_o = 174591;
                    punc_o = 1;
                case 193
                    idx_o = 262003;
                    punc_o = 2;
                case 194
                    idx_o = 207871;
                    punc_o = 1;
                case 195
                    idx_o = 29720;
                    punc_o = 0;
                case 196
                    idx_o = 261721;
                    punc_o = 2;
                case 197
                    idx_o = 61951;
                    punc_o = 1;
                case 198
                    idx_o = 261786;
                    punc_o = 2;
                case 199
                    idx_o = 95231;
                    punc_o = 1;
                case 200
                    idx_o = 128216;
                    punc_o = 0;
                case 201
                    idx_o = 261913;
                    punc_o = 2;
                case 202
                    idx_o = 160255;
                    punc_o = 1;
                case 203
                    idx_o = 261978;
                    punc_o = 2;
                case 204
                    idx_o = 193535;
                    punc_o = 1;
                case 205
                    idx_o = 13208;
                    punc_o = 0;
                case 206
                    idx_o = 261688;
                    punc_o = 2;
                case 207
                    idx_o = 46591;
                    punc_o = 1;
                case 208
                    idx_o = 261753;
                    punc_o = 2;
                case 209
                    idx_o = 78335;
                    punc_o = 1;
                case 210
                    idx_o = 111290;
                    punc_o = 0;
                case 211
                    idx_o = 261880;
                    punc_o = 2;
                case 212
                    idx_o = 144895;
                    punc_o = 1;
                case 213
                    idx_o = 261945;
                    punc_o = 2;
                case 214
                    idx_o = 176639;
                    punc_o = 1;
                case 215
                    idx_o = 209786;
                    punc_o = 0;
                case 216
                    idx_o = 261658;
                    punc_o = 2;
                case 217
                    idx_o = 29695;
                    punc_o = 1;
                case 218
                    idx_o = 261720;
                    punc_o = 2;
                case 219
                    idx_o = 62975;
                    punc_o = 1;
                case 220
                    idx_o = 94361;
                    punc_o = 0;
                case 221
                    idx_o = 261850;
                    punc_o = 2;
                case 222
                    idx_o = 127999;
                    punc_o = 1;
                case 223
                    idx_o = 261912;
                    punc_o = 2;
                case 224
                    idx_o = 161279;
                    punc_o = 1;
                case 225
                    idx_o = 192857;
                    punc_o = 0;
                case 226
                    idx_o = 262042;
                    punc_o = 2;
                case 227
                    idx_o = 14335;
                    punc_o = 1;
                case 228
                    idx_o = 261693;
                    punc_o = 2;
                case 229
                    idx_o = 47615;
                    punc_o = 1;
                case 230
                    idx_o = 80507;
                    punc_o = 0;
                case 231
                    idx_o = 261820;
                    punc_o = 2;
                case 232
                    idx_o = 112639;
                    punc_o = 1;
                case 233
                    idx_o = 261885;
                    punc_o = 2;
                case 234
                    idx_o = 145919;
                    punc_o = 1;
                case 235
                    idx_o = 179003;
                    punc_o = 0;
                case 236
                    idx_o = 262012;
                    punc_o = 2;
                case 237
                    idx_o = 210943;
                    punc_o = 1;
                case 238
                    idx_o = 261660;
                    punc_o = 2;
                case 239
                    idx_o = 30719;
                    punc_o = 1;
                case 240
                    idx_o = 63581;
                    punc_o = 0;
                case 241
                    idx_o = 261787;
                    punc_o = 2;
                case 242
                    idx_o = 97279;
                    punc_o = 1;
                case 243
                    idx_o = 261852;
                    punc_o = 2;
                case 244
                    idx_o = 129023;
                    punc_o = 1;
                case 245
                    idx_o = 162077;
                    punc_o = 0;
                case 246
                    idx_o = 261979;
                    punc_o = 2;
                case 247
                    idx_o = 195583;
                    punc_o = 1;
                case 248
                    idx_o = 262044;
                    punc_o = 2;
                case 249
                    idx_o = 15359;
                    punc_o = 1;
                case 250
                    idx_o = 46652;
                    punc_o = 0;
                case 251
                    idx_o = 261757;
                    punc_o = 2;
                case 252
                    idx_o = 80383;
                    punc_o = 1;
                case 253
                    idx_o = 261819;
                    punc_o = 2;
                case 254
                    idx_o = 113663;
                    punc_o = 1;
                case 255
                    idx_o = 145148;
                    punc_o = 0;
                case 256
                    idx_o = 261949;
                    punc_o = 2;
                case 257
                    idx_o = 178687;
                    punc_o = 1;
                case 258
                    idx_o = 262011;
                    punc_o = 2;
                case 259
                    idx_o = 211967;
                    punc_o = 1;
            end
    end
end

function val = bitconcat(a, a_bits, b, b_bits)
    val = bitor(bitshift(a, b_bits), b);
end
