% BW = segmentacion(I)
%
% Proyecto Visión Artificial
%
%    Este método .... (INCLUIR DESCRIPCIÓN)
%
%    Input:
%       I Imagen a a escala de grises tipo uint3
%
%    Output:
%       BW Imagen en blanco y negro con los obejetos de interes
%
%
% Autor_1
% Autor_2
% Autor_3
% Universidad Nacional de Colombia, sede Medellín
 
function BW = segmentacion(I)
    Ialt=I;
    Ialt(Ialt>10)=255;
    %Binarización
    figure,imshow(Ialt)
    I=255-Ialt;
    % Elementos estructurantes para las operaciones morfológicas
    SE = strel('disk',5);
    BW = imdilate(I,SE);
end
