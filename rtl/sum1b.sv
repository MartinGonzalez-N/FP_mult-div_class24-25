`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/18/2025 05:40:52 PM
// Design Name: 
// Module Name: sum1b
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module sum1b (a,b,ci,so,co);
	//Puertos
	//sentido  tipo   tamaño   nombre 
	input 			   a,b,ci;
	output			   so,co;
	//Alambres
	//tipo       tamaño  nombre
	wire			  			x0,x1,x2;
	
	//Registros

//Asignaciones////
//	assign So= Ci^(A^B);
//	assign Co= (A&B)|(Ci&(A^B));

	assign x0=a^b;
	assign x1=x0&ci;
	assign x2=a&b;
	assign so=x0^ci;
	assign co=x1|x2;

endmodule