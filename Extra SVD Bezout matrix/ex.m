
function [a,b,c,rankloss]=ex(n)

% This function is a database of pairs of polynomials. The pairs of
% polynomials are indexed by n.

% The matrices a and b define polynomials, where the first column of a
% and b defines the root, and the second column defines the multiplicity
% of the root.

% The matrix c stores the GCD of a and b, in the same format as a and b.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

switch n
    
    case 1
a=[0.1,   3;
   0.5,   3;
   0.7,   3;
   1.3,   3;
  -1.7,   3;
   2.2,   3];

b=[0.1,   4;
   0.5,   5;
   0.7,   2;
   1.0,   3;
  -1.0,   3;
   2.2,   5];

c=[0.1,   3;
   0.5,   3;
   0.7,   2;
   2.2,   3];

rankloss = 11;

    case 2
a=[0.1,   4;
   0.6,   5;
   0.9,   4;
   1.4,   5;
  -1.6,   5;
   2.0,   3];

b=[-0.1,  5;
    0.6,  4;
    0.9,  4;
   -1.4,  3;
   -1.6,  7;
   -2.0,  3];

c=[ 0.6,  4;
    0.9,  4;
   -1.6,  5];

rankloss = 13;

    case 3
a=[0.3,   5;
  -0.6,   4;
  -1.1,   5;
   2.7,   5;
   1.1,   2];

b=[0.8,   6;
  -0.6,   5;
  -1.1,   3;
   2.7,   5;
  -0.8,   2];

c=[-0.6,   4;
   -1.1,   3;
    2.7,   5];

rankloss = 12;

    case 4
a=[0.1,   4;
   0.5,   3;
   0.9,   4;
   1.4,   5;
  -0.7,   4;
   2.4,   3;
   1.0,   4];

b=[0.1,   2;
   0.7,   2;
   0.9,   5;
   1.4,   5;
  -0.7,   4;
  -2.4,   3;
  -1.0,   4];

c=[0.1,   2;
   0.9,   4;
   1.4,   5;
  -0.7,   4];

rankloss = 15;
    
    case 5
a=[0.14,  3;
   0.56,  3;
   0.89,  4;
   1.45,  4;
   2.37,  5;
  -3.61,  5];

b=[0.14,  4;
  -0.76,  2;
   0.99,  1;
  -1.24,  2;
   2.37,  3;
  -3.61,  7];

c=[0.14,  3;
   2.37,  3;
  -3.61,  5];

rankloss = 11;
    
    case 6
a=[0.23,  5;
   0.56,  4;
   0.79,  3;
  -1.57,  5;
   3.61,  3;
   8.71,  5];

b=[0.23,  6;
   0.56,  3;
   0.79,  2;
  -1.57,  6;
  -2.61,  2;
   8.71,  6];

c=[0.23,  5;
   0.56,  3;
   0.79,  2;
  -1.57,  5;
   8.71,  5];

rankloss = 20;
      
    case 7
a=[0.23,  5;
   0.56,  4;
   0.79,  3;
  -1.57,  3;
  -2.61,  3;
   4.71,  3;
   1.45,  4];

b=[0.23,  4;
  -0.36,  3;
  -0.49,  2;
   1.32,  2;
  -2.61,  2;
   4.71,  3;
   1.45,  5];

c=[0.23,  4;
  -2.61,  2;
   4.71,  3;
   1.45,  4];

rankloss = 13;
    
    case 8
a=[0.10,  3;
   0.56,  5;
   1.40,  4;
  -2.68,  3;
   1.79,  3;
   2.69,  2];

b=[0.10,  4;
   0.56,  4;
  -1.40,  2;
   2.68,  2;
   1.79,  3;
   2.69,  3];

c=[0.10,  3;
   0.56,  4;
   1.79,  3;
   2.69,  2];

rankloss = 12;
    
    case 9
a=[0.10,  3;
   0.56,  4;
   0.75,  3;
   0.82,  3;
   1.37,  3;
  -0.27,  3;
   1.46,  2];

b=[0.10,  2;
   0.56,  4;
   0.75,  3;
   0.99,  4;
   1.37,  3;
   2.12,  3;
  -1.20,  3];

c=[0.10,  2;
   0.56,  4;
   0.75,  3;
   1.37,  3];

rankloss = 12;
    
    case 10
a=[-0.20,  4;
   -0.60,  3;
    0.90,  4;
    9.60,  5;
   -4.30,  4;
   -2.00,  2];

b=[0.20,   6;
   0.60,   2;
   0.90,   3;
   9.60,   5;
  -4.30,   3;
   2.60,   2];

c=[0.90,   3;
   9.60,   5;
  -4.30,   3];

rankloss = 11;
    
    case 11
a=[-0.10,  4;
   -0.50,  3;
    0.90,  4;
    9.60,  5;
   -4.30,  4;
   -2.00,  3];

b=[0.20,   6;
   0.60,   2;
   0.90,   3;
   9.60,   5;
  -4.30,   3;
   2.60,   2];

c=[0.90,   3;
   9.60,   5;
  -4.30,   3];

rankloss = 11;
    
    case 12
a=[0.30,   6;
   0.60,   4;
   0.90,   6;
   9.70,   2;
  -4.60,   2;
  -2.30,   2];

b=[0.30,   5;
   0.60,   5;
   0.90,   7;
   9.70,   2;
   4.60,   2;
   2.30,   2];

c=[0.30,   5;
   0.60,   4;
   0.90,   6;
   9.70,   2];

rankloss = 17;
    
    case 13
a=[0.23,   4;
   0.43,   3;
   0.57,   3;
   0.92,   3;
   1.70,   3];

b=[0.23,   4;
   0.30,   2;
   0.77,   5;
   0.92,   2;
   1.20,   5];

c=[0.23,   4;
   0.92,   2];

rankloss = 6;

    case 14
a=[-0.10,  3;
    0.50,  4;
    0.70,  4;
    0.99,  3;
   -1.30,  3;
    1.50,  4];

b=[-0.10,  4;
    0.50,  5;
    0.70,  2;
    0.90,  4;
    1.30,  2;
    1.50,  3];

c=[-0.10,  3;
    0.50,  4;
    0.70,  2;
    1.50,  3];

rankloss = 12;

    case 15
a=[0.20,   3;
   0.60,   3;
   0.80,   3;
  -1.35,   2;
   1.90,   4];

b=[0.20,   2;
   0.60,   5;
   0.80,   5;
   1.35,   3;
  -2.00,   3];

c=[0.20,   2;
   0.60,   3;
   0.80,   3];

rankloss = 8;

    case 16
a=[-4.00,  2;
    0.10,  5;
    0.50,  3;
    1.40,  3;
   -1.60,  3];

b=[0.70,   4;
   0.10,   3;
  -0.50,   2;
   1.40,   4;
   6.00,   4];

c=[0.10,   3;
   1.40,   3];

rankloss = 6;

    case 17
a=[0.10,   4;
   0.50,   5;
   0.90,   5;
   5.00,   6;
  -2.60,   4];

b=[-0.10,  5;
    0.50,  4;
    0.90,  4;
    5.00,  4;
    2.00,  4];

c=[0.50,  4;
   0.90,  4;
   5.00,  4];

rankloss = 12;

    case 18
a=[0.10,   4;
   0.50,   5;
   0.90,   5;
   5.00,   6;
  -2.60,   4];

b=[-0.10,   5;
   -0.50,   1;
    0.90,   4;
    5.00,   4;
    2.00,   4];

c=[0.90,   4;
   5.00,   4];

rankloss = 8;

    case 19
a=[0.10,   3;
   0.40,   4;
   0.50,   4;
   0.70,   4;
   0.90,   3];

b=[0.10,  5;
   0.40,  3;
   0.50,  6;
   0.70,  5;
   0.90,  4];

c=[0.10,  3;
   0.40,  3;
   0.50,  4;
   0.70,  4;
   0.90,  3];

rankloss = 17;

    case 20
a=[0.10,   3;
   0.20,   4;
   0.50,   4;
   0.70,   4;
   0.90,   3];

b=[0.10,   5;
   0.40,   3;
   0.50,   6;
   0.70,   5;
   0.90,   4];

c=[0.10,   3;
   0.50,   4;
   0.70,   4;
   0.90,   3];

rankloss = 14;

    case 21
a=[0.10,   3;
   0.50,   6;
   0.90,   4;
  -1.40,   4;
   5.60,   3;
   1.70,   4];

b=[0.10,   4;
   0.50,   4;
   0.90,   5;
   1.40,   1;
   5.60,   4;
   1.70,   3];

c=[0.10,   3;
   0.50,   4;
   0.90,   4;
   5.60,   3;
   1.70,   3];

rankloss = 17;

    case 22
a=[0.10,   3;
   0.50,   6;
   0.90,   4;
  -1.40,   4;
   5.60,   3;
   1.70,   4];

b=[-0.10,  4;
    0.50,  4;
    0.90,  5;
    1.40,  1;
    5.60,  4;
    1.70,  3];

c=[0.50,  4;
   0.90,  4;
   5.60,  3;
   1.70,  3];

rankloss = 14;

    case 23
a=[0.10,   6;
   0.40,   7;
   0.80,   4;
   0.90,   5;
  -1.20,   1;
   1.30,   1;
   2.00,   1];

b=[0.10,   7;
   0.40,   4;
   0.80,   7;
   0.90,   6;
   1.20,   1;
  -1.30,   1;
  -2.00,   1];

c=[0.10,   6;
   0.40,   4;
   0.80,   4;
   0.90,   5];

rankloss = 19;

    case 24
a=[0.10,   4;
   0.50,   4;
   0.80,   5;
   0.90,   3;
  -1.30,   7];

b=[0.10,   4;
   0.50,   4;
   0.80,   5;
   0.90,   3;
   1.30,   7];

c=[0.10,   4;
   0.50,   4;
   0.80,   5;
   0.90,   3];

rankloss = 16;

    case 25
a=[0.10,   3;
   0.30,   4;
   0.60,   4;
   0.80,   5;
   0.40,   5;
   1.50,   4];

b=[-0.10,  5;
   -0.30,  2;
   -0.60,  4;
   -0.80,  6;
    0.40,  5;
    1.50,  4];

c=[0.40,  5;
   1.50,  4];

rankloss = 9;

    case 26
a=[0.10,   7;
   0.90,   8;
   1.30,   2;
   2.40,   3];

b=[-0.10,  8;
    0.90,  8;
   -1.30,  6;
   -2.40,  6];

c=[0.90,  8];

rankloss = 8;

    case 27
a=[0.13,   3;
   0.43,   2;
   0.78,   3;
   0.93,   3;
   1.34,   3;
  -0.78,   3];

b=[0.13,   4;
   0.23,   4;
   0.53,   4;
   0.93,   3;
  -1.34,   2;
  -0.36,   2];

c=[0.13,   3;
   0.93,   3];

rankloss = 6;

    case 28
a=[0.10,   3;
   0.56,   5;
   0.90,   4;
  -2.68,   3;
   1.79,   3;
   2.69,   2];

b=[0.10,   4;
   0.56,   4;
  -1.40,   2;
   2.68,   2;
   0.75,   3;
   2.69,   3];

c=[0.10,   3;
   0.56,   4;
   2.69,   2];

rankloss = 9;

    case 29
        
a=[0.20,   4;
   0.30,   6;
   0.90,   4];
               
b=[0.20,   3;
   0.60,   3;
   0.80,   3];

c=[0.20,   3];

rankloss = 3;

    case 30
        
a=[0.20,   4;
   0.30,   2;
   0.90,   4;
   1.40    3];
               
b=[0.20,   3;
   0.60,   3;
   0.90,   2;
   1.90    4];

c=[0.20,   3;
   0.90    2];

rankloss = 5;

    case 31
        
a=[-0.30,   4;
    0.10    5;
    0.30,   2;
    0.90,   4;
    1.40    3];
               
b=[0.20,   3;
   0.60,   3;
   0.90,   2;
   1.40    4];

c=[0.90,   2;
   1.40    3];

rankloss = 5;

    case 32
        
a=[0.10    2;
   0.30,   4;
   0.50,   2;
   0.80    2];
               
b=[0.20,   3;
   0.30,   2;
   0.50,   2;
   0.90    4];

c=[0.30,   2;
   0.50    2];

rankloss = 4;

    case 33
        
a=[0.10    5;
   0.30,   3;
   0.90    5];
               
b=[0.20,   3;
   0.30,   2;
   0.90    4];

c=[0.30,   2;
   0.90    4];

rankloss = 6;

    case 34
        
a=[0.50    6;
   0.70    2];
               
b=[0.50    5];

c=[0.50,   5];

rankloss = 5;

    case 35
        
a=[0.50    6;
   0.70    2;
   0.90    2];
               
b=[0.50    5;
   0.90    3];

c=[0.50,   5;
   0.90    2];

rankloss = 7;

    case 36
        
a=[0.50    2;
   0.70    2;
   0.90    2];
               
b=[0.50    1;
   0.90    1];

c=[0.50,   1;
   0.90    1];

rankloss = 2;

end