//function B=rot90(A,varargin)

//Return a copy of A with the elements rotated counterclockwise in 90-degree increments.

//     The second argument is optional, and specifies how many 90-degree  rotations are to be applied (the default value is 1).
// Negative values of K rotate the matrix in a clockwise direction.


// Parameters
//A: Matrix : Input to rot90
//k : The second argument is optional, and specifies how many 90-degree  rotations are to be applied         (the default value is 1).
// Negative values of K rotate the matrix in a clockwise direction.

// Description
// This function returns a matrix which is equal to: " input matrix A rotated by 90 degrees anticlockwise, k times".
// The second input parameter is not necessary, by default its value is set to 1.
//The rotation is always performed on the plane of the first two dimensions, i.e., rows and columns.

//Example:
//A=[1 2 3;4 5 6];
//B=rot90(A)
//C=rot90(A,2)

//Output:
//B=[   3   6
//         2   5
//         1   4]

//C = [   6   5   4
//            3   2   1]

