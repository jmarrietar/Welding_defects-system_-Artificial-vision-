%%%%%%%%%%%
% ENTRENAMIENTO
%%%%%%%%%%%


% Para leer lás imégenes de prueba
imagefiles = dir('train/*.jpg');
nfiles = length(imagefiles);

d = [];
X = [];

for i=1:nfiles
   
    file = imagefiles(i).name;
    I = imread(sprintf ('train/%s',file));

    % Preprocese la imagen
    I2 = preProcesamiento(I);
    %figure(1), imshow(I2, []);

    %Segemneta la imagen
    BW = segmentacion(I2);
    %figure(2), imshow(BW, []);   
    
    %Etiqueta la imagen
    [L, N, d1] = etiquetadoDeObjetos( BW, true, 2);
 
    %Extracción de caracteristicas
    [X1, Xn] = extraccionDeCaracteristicas(I2, L)

    d = [d; d1];
    X = [X; X1];
end

% Seleccón de características
op1.train = true;
op1.pca = true;
op1.d = d;

[New_X, New_Xn, op1] = seleccionDeCaracteristicas(X, Xn, op1,d);

% Clasificación
op2.train = true;
op2.d = d;
[ds, op2] = clasificacionDeDefectos(New_X, op2);


% Bio_decisionline(New_X(:,[1 2]), d, New_Xn([1 2], :), op2.options);


%%%%%%%%%%%
% PRUEBA
%%%%%%%%%%%


% Para leer lás imégenes de prueba
imagefiles = dir('test/*.bmp');
%imagefiles = dir('test/*.jpg');
nfiles = length(imagefiles);

for i=1:nfiles
   
    file = imagefiles(i).name;
    I = imread(sprintf ('test/%s',file));

    % Preprocese la imagen
    I2 = preProcesamiento(I);
    %figure(1), imshow(I2, []);

    %Segemneta la imagen
    BW = segmentacion(I2);
    %figure(2), imshow(BW, []);   
    
    %Etiqueta la imagen
    [L, N, ~] = etiquetadoDeObjetos(I2, BW, false);
 
    %Extracción de caracteristicas
    [Xt, Xn] = extraccionDeCaracteristicas(I2, L);

    %Seleccion de caracteristicas
    [New_Xt, New_Xnt, op1] = seleccionDeCaracteristicas(X, Xn, op1);
    
    % Clasificación de los defectos
    [ds, op] = clasificacionDeDefectos(New_Xt, op2);
    
    R = I2;
    G = I2;
    B = I2;
    
    p   = 1:size(ds,1);
    df  = p(ds==1);
    ndf = p(ds==2);
    
    for j=1:size(df,2)
        R(L == df(j)) = 255;
        G(L == df(j)) = 0;
        B(L == df(j)) = 0;
    end
    
    for j=1:size(ndf,2)
        R(L == ndf(j)) = 0;
        G(L == ndf(j)) = 0;
        B(L == ndf(j)) = 255;
    end
    
    figure(1), imshow(I2, []);
    figure(1), imshow(I2, []);
    figure(2), imshow(cat(3, R, G, B));
    showfigs;
    enterpause;
end

