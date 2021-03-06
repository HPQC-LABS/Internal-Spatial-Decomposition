%% Decomposition of a given CS matrix into internal and beamsplitter matrices

% This code implements the decomposition algorothm presented in Section
% IIIc of article "Realization of arbitrary discrete unitary transformation
% using spatial and internal modes of light" by Ish Dhand and Sandeep Goyal.
%
% The inputs comprise:
% U, a 2n_p X 2n_p unitary matrix to be decomposed
% np, the number of internal modes
%
% The output of the code is a cell of 2n_p X 2n_p matrices, each of which
% represents either an internal transformation or a beamsplitter
% transformation.
%
% For an illustration of using this code, refer to Driver.m

function BS = CSMatrix(S,np)

% S is the CS matrix

Theta = real(acos(diag(S(1:np,1:np)))); % Use the CS matrix to compute the theta values

Trans = ones(np) - 2*eye(np); % Transformation that connects the new thetas to the old ones
InvTrans = inv(Trans); % inverse transformation

Theta_prime = real(InvTrans*Theta) % Solve a linear system to obtain beamsplitter thetas

BS = cell(1,3*np);

for i = 1:np
    BS{3*(i-1)+1} = blkdiag(eye(np),diag(Trans(i,:))); % Sigma matrix
    BS{3*(i-1)+2} = real(kron(BS_Matrix(Theta_prime(i)),eye(np))); % BS matrix using theta_prime
    BS{3*(i-1)+3} = BS{3*(i-1)+1}; % Sigma matrix
end

end

% Computing the beamsplitter matrices
function B = BS_Matrix(theta)

B = [diag(cos(theta)) diag(sin(theta)); -diag(sin(theta)) diag(cos(theta))];

end
