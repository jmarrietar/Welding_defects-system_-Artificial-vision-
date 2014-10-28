% [New_X, New_Xn] = seleccionDeCaracteristicas(X, Xn, op)
%
% Proyecto Visión Artificial
%
%    Este método .... (INCLUIR DESCRIPCIÓN)
%
%    Input:
%       X   Matriz original de características
%       Xn  Nombres de las características
%       op.train Indica si se hace el proceso de seleccion para entrenar (Por defecto: true)
%       op.pca Aplicar PCA(Por defecto: true)
%       op.d Vector de la clasificación ideal de los datos
%
%    Output:
%       New_X  Matriz de nuevas características
%       New_Xn Nombres de las características sleccionadas
%
% Autor_1
% Autor_2
% Autor_3
% Universidad Nacional de Colombia, sede Medellín
 
function [New_X, New_Xn, op] = seleccionDeCaracteristicas(X, Xn, op,d)

    %%%%
    % SI SOLO VA A ENTRENAR
    %%%%
    if (op.train)
        
        opt.train = false;
        
        % PROCESO DE SELECCIÓN
        opc.m      = 22;          % Extrae 20 características
        opc.b.name = 'fisher';    % Usando el criterio de Fisher
        opc.s      = 1;           % Usa el 80% de los datos para el calculo de la métrica
        opc.show   = 1;           % Despliegue resultados

        selec=Bfs_sfs(X,d,opc)  

        New_X  = X(:,selec);                       
        New_Xn = Xn(selec, :);
    
        opt.selec = selec;
        
        % PROCESO DE TRANSFORMACION CON PCA
    %    if (op.pca)
    %        opt.pca = true;
    %        opt.c   = 3;    %Extrae 3 Componentes principales
    %        
    %        [X2, ~, A, ~] = Bft_pca(New_X, opt.c); 

    %        % Parámetros requeridos para la transformacion con PCA
    %        opt.mx = mean(New_X);
    %        opt.A = A(:, 1:opt.c);
    %        
    %        [New_X, opt.a, opt.b] = Bft_norm(X2, 0);
           
            % NOMBRES DE LAS COMPONENTES
    %        New_Xn = char(zeros(opt.c, 25));

    %        for i=1:opt.c
    %            s = sprintf('PCA_%d                                ',i);
    %            New_Xn(i,:) = s(1:25);
    %        end
    %        opt.Xn = New_Xn;
    %    end
    
        %Reemplaza las viejas opciones por la nuevas
        op = opt;
        
    %%%%    
    % SI SE VA A USAR LA SELECCIÓN REALIZADA CON ANTERIORIDAD
    %%%%
    else
        New_X  = X(:,op.selec);
        New_Xn = Xn(op.selec, :);
        
        % TRANSFORMA CON LA MATRIZ DE TRANSFORMACION CREADA EN EL ENTRENAMIENTO
       % if (op.pca)
       %     MX = ones(size(New_X,1),1)*op.mx;
       %     X0 = New_X - MX;
       %     
        %    New_X = X0 * op.A;
        %    New_X = New_X * diag(op.a) + ones(size(New_X,1),1)*op.b;
        %    New_Xn = op.Xn;
        %end
    end
end
