% [X, Xn] = extraccionDeCaracteristicas(Ig, L)
%
% Proyecto Visión Artificial
%
%    Extraera las caracteristicas de los objetos etiquetados mas especificamente 
%  center of grav i [px]   	Hu-moment 4             	G-Intensity Skewness    	G-wsLBP(8,1)[8x8]       
%center of grav j [px]   	Hu-moment 5             	G-Mean Laplacian        	G-wsLBP(9,1)[8x8]       
%Height [px]             	Hu-moment 6             	G-Mean Boundary Gradient	G-wsLBP(10,1)[8x8]      
%Width [px]              	Hu-moment 7             	G-Hu-moment-int 1       	G-wsLBP(11,1)[8x8]      
%Area [px]               	Flusser-moment 1        	G-Hu-moment-int 2       	G-wsLBP(12,1)[8x8]      
%Perimeter [px]          	Flusser-moment 2        	G-Hu-moment-int 3       	G-wsLBP(13,1)[8x8]      
%Roundness               	Flusser-moment 3        	G-Hu-moment-int 4       	G-wsLBP(14,1)[8x8]      
%Danielsson factor       	Flusser-moment 4        	G-Hu-moment-int 5       	G-wsLBP(15,1)[8x8]      
%Euler Number            	Moment 0,0              	G-Hu-moment-int 6       	G-wsLBP(16,1)[8x8]      
%Equivalent Diameter [px]	Moment 1,0              	G-Hu-moment-int 7       	G-wsLBP(17,1)[8x8]      
%MajorAxisLength [px]    	Moment 0,1              	G-DCT(1,1)              	G-contrast-K1           
%MinorAxisLength [px]    	Fourier-des  1          	G-DCT(1,2)              	G-contrast-K2           
%Orientation [grad]      	Fourier-des  2          	G-DCT(2,1)              	G-contrast-K3           
%Solidity                	Fourier-des  3          	G-DCT(2,2)              	G-contrast-Ks           
%Extent                  	Fourier-des  4          	G-wsLBP(1,1)[8x8]       	G-contrast-K 
%Eccentricity            	Gupta-moment 1          	G-wsLBP(2,1)[8x8]       	
%Convex Area [px]        	Gupta-moment 2          	G-wsLBP(3,1)[8x8]       	
%Filled Area [px]        	Gupta-moment 3          	G-wsLBP(4,1)[8x8]       	
%Hu-moment 1             	G-Intensity Mean        	G-wsLBP(5,1)[8x8]       	
%Hu-moment 2             	G-Intensity StdDev      	G-wsLBP(6,1)[8x8]       	
%Hu-moment 3             	G-Intensity Kurtosis    	G-wsLBP(7,1)[8x8]       	

%
%    Input:
%       Ig  Imagen Original en niveles de gris
%       BW  Imagen en blanco y negro (Imgen segmentada)
%       L Imagen de etiquetas
%       N Número de objetos en la imagen
%
%    Output:
%       X  Matriz de características
%       Xn Nombres de las características extraidas
%
% Autor_1
% Autor_2
% Autor_3
% Universidad Nacional de Colombia, sede Medellín

function [X, Xn] = extraccionDeCaracteristicas(Ig, L)

    % Características GEOMËTRICAS (requieren una imagen etiquetada)
b(1).name = 'basicgeo'; b(1).options.show=1;
b(2).name = 'hugeo'; b(2).options.show=1;
b(3).name = 'flusser'; b(3).options.show=1;
b(4).name = 'moments'; b(4).options.show=1; b(4).options.central=0;b(4).options.rs = [0 0; 1 0; 0 1];
b(5).name = 'fourierdes'; b(5).options.show=1;  b(5).options.Nfourierdes=4;
b(6).name = 'gupta'; b(6).options.show=1; % Bien

    op.b = b;
    [X1,X1n] = Bfx_geo(L, op);

    % Características e INTENSIDAD (requieren una imagen en nieveles de gris)
    b = [];
    b(1).name = 'basicint'; b(1).options.show=1;  
    b(2).name = 'huint';    b(2).options.show=1;
 b(3).name = 'dct';  b(3).options.Ndct  = 64;                % imresize vertical
        b(3).options.Mdct  = 64;                % imresize horizontal
        b(3).options.mdct  = 2;                 % imresize frequency vertical
        b(3).options.ndct  = 2;                 % imresize frequency horizontal
        b(3).options.show    = 1;               % display results % Poner demas para metros 

 b(4).name = 'lbp'; b(4).options.vdiv = 1;                  % one vertical divition
       b(4).options.hdiv = 1;                  % one horizontal divition
       b(4).options.semantic = 1;              % semantic LBP
       b(4).options.samples = 8;               % number of neighbor samples
       b(4).options.sk      = 0.25;            % angle sampling
       b(4).options.weight  = 9;               % angle sampling
	   
	  b(5).name = 'contrast';   b(5).options.show    = 1;                    % display results
        b(5).options.neighbor = 2;                   % neigborhood is imdilate
        b(5).options.param    = 5;                   % with 5x5 mask
		
		
    op.b = b;
    op.colstr = 'G';
    [X2,X2n] = Bfx_int(Ig, L, op);

    X  = [X1 X2];
    Xn = [X1n; X2n];

end
