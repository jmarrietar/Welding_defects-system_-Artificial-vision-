% [X, Xn] = extraccionDeCaracteristicas(Ig, L)
%
% Proyecto Visión Artificial
%
%    Este método .... (INCLUIR DESCRIPCIÓN)
%
%    Input:
%       X  Matriz de características
%       op.train Deterina si está entrenado o probando (Por defecto: true)
%       op.d Vector de clasificación ideal (solo para ENTRENAMMIENTO)
%
%    Output:
%       ds Clasificación echa por el clasificador
%       op Parámetros del Clasificador
%
% Autor_1
% Autor_2
% Autor_3
% Universidad Nacional de Colombia, sede Medellín
 
function [ds, op] = clasificacionDeDefectos(X, op)

    if (op.train)

        opt.train = false;

        b(1).name = 'lda';   b(1).options.p=[];  % Es el que tuvo mejor Desempeño 
        opt.options = Bcl_structure(X, op.d, b);

        ds = Bcl_structure(X, opt.options);
        op = opt;
    else
        ds = Bcl_structure(X, op.options);
    end

end
