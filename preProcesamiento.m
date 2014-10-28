% New_I = preProcesamiento(I)
%
% Proyecto Visión Artificial
%
%    Este método .... (INCLUIR DESCRIPCIÓN)
%
%    Input:
%       I imagen a color tipo uint8
%
%    Output:
%       New_I Imagen preprocesada de tipo uint
%
%
% Autor_1
% Autor_2
% Autor_3
% Universidad Nacional de Colombia, sede Medellín
 
function New_I = preProcesamiento(I)
%=======anterior
    % Si la imagen es a color
    %I=imresize(I,0.4);
    %Inversa=rgb2gray(255-I);
    %Se pasa a escala de grises la imagen y se invierten sus colores
    %I = nlfilter(Inversa,[11 11],@minFil);
    %I=medfilt2(I,[5 5]);
    %Se aplican los filtros mínimo y mediana sobre la imagen
    %New_I=I;   
%============
%=====nuevo
    % Si la imagen es a color
    I=imresize(I,0.4);
    I=medfilt2(I,[5 5]);
    Inversa=rgb2gray(255-I);
    Inversa(Inversa<50)=0;
    %Se pasa a escala de grises la imagen y se invierten sus colores
    I = nlfilter(Inversa,[11 11],@minFil);
    %Se aplican los filtros mínimo y mediana sobre la imagen
    New_I=I;   
end
