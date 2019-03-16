% Symbolic expressions for d(Dinv * P1inv * P2)/d{eps1,eps2}
% Section 10.3.10 of Technical report:
% "A tutorial on SE(3) transformation parameterizations and on-manifold optimization"
%
% Requires MATLAB or Octave + symbolic pkg.
%
% Jose Luis Blanco Claraco, March 2019

function [] = jacob_DinvP1invP2()
  syms AR00 AR01 AR02 AR10 AR11 AR12 AR20 AR21 AR22 Ax Ay Az real
  TA=[[AR00 AR01 AR02 Ax];[AR10 AR11 AR12 Ay];[AR20 AR21 AR22 Az];[0 0 0 1]]

  syms BR00 BR01 BR02 BR10 BR11 BR12 BR20 BR21 BR22 Bx By Bz real
  TB=[[BR00 BR01 BR02 Bx];[BR10 BR11 BR12 By];[BR20 BR21 BR22 Bz];[0 0 0 1]]

  syms DinvR00 DinvR01 DinvR02 DinvR10 DinvR11 DinvR12 DinvR20 DinvR21 DinvR22 Dinvx Dinvy Dinvz real
  TDinv=[[DinvR00 DinvR01 DinvR02 Dinvx];[DinvR10 DinvR11 DinvR12 Dinvy];[DinvR20 DinvR21 DinvR22 Dinvz];[0 0 0 1]]
  
  %syms e1x e1y e1z real
  %eps1=[e1x e1y e1z]'
  
  J3 = jacob_Dexpe_de(TA)
    
  [J2, Jx] = jacob_AB_dA_dB(TA,TB)

  %J1 = jacob_pseudoLnSE3()
end

% Section 10.3.4 of tech. report
function [J] = jacob_Dexpe_de(D)
%  J=zeros(12,6); nope!
  R=D(1:3,1:3);
  J(10:12,1:3) = R;
  
  dc1=R(:,1);
  dc2=R(:,2);
  dc3=R(:,3);
  
  r1=1:3;
  r2=4:6;
  r3=7:9;
  
  J(r2,6) = -dc1;
  J(r3,5) =  dc1;
    
  J(r1,6) =  dc2;
  J(r3,4) = -dc2;

  J(r1,5) = -dc3;
  J(r2,4) =  dc3;  
end


% Section 7.3.3 of tech. report
function [J] = jacob_invA_dA(A)
%  J=zeros(12,6); nope!
  R=A(1:3,1:3);
  J(10:12,10:12) = -R';
  
  ta=A(1:3,4);
  J(10:12,1:9) = kron(eye(3),-ta');
  J(1:9,1:9) = perm_matrix_3x3();  
end

% Section 7.1 of tech. report
function [P] = perm_matrix_3x3()
    P=zeros(9,9);
    for j=1:3
        for i=1:3
            P(((i-1)*3+j),((j-1)*3+1)) = 1;
        end
    end
end

% Section 7.3.1 of tech. report
function [J_wrt_A, J_wrt_B] = jacob_AB_dA_dB(A,B)
    J_wrt_A = kron(B,eye(3));
    J_wrt_B = kron(eye(4),A(1:3,1:3));
end

