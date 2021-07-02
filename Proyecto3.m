%Proyecto #3 ---Lorena Pérez
%Comparacion entre polinomios interpolantes y regresion lineal
%Informacion dada en el documento
%t=[21 24 32 47 51 59 68 74 62 50 41 30];
%v=[185.79 214.47 288.03 424.84 454.58 539.03 621.55 675.06 562.03 452.93 369.95 273.98];

function p3=Proyecto3();
  printf('\nComparacion entre polinomios interpolantes y regresion lineal. \n');
  printf('\nSe considera que el numero de libras de vapor consumidos mensualmente por una planta \nquimica estarelacionado con la temperatura ambiente promedio (en °F) \npara cada mes especifico.\n');
  printf('\nNOTA: Los datos que se analizaran deben tener el mismo largo. No podra continuar hasta llenar esa columna de datos.\n');
  printf('\nIngrese el # de datos a almacenar. \n');
  %Solicitud de datos --Inciso A y B:
  datos=input('# de datos a ingresar: ');
  printf('\nIngrese los datos de temperatura. \n');
  for i=1:datos;
    fprintf('t(%.0f) = ',i);
    t(i)=input(' ');
  endfor
  printf('\nIngrese los datos del consumo de vapor. \n');
  for i=1:datos;
    fprintf('v(%.0f) = ',i);
    v(i)=input(' ');
  endfor
  
  
  
  %Inciso D: Regresion lineal simple
  n=length(t); %determina la longitud o tamanio del vector t
  if length(v)~=n, error('debe haber la misma cantidad de valores para x e y'); %el cosito de la enie se llama virulilla
  endif
  t=t(:); v=v(:); %convierte cada vector a columna
  st=sum(t); sv=sum(v); %suma las columnas de x y de y
  st2=sum(t.*t); stv=sum(t.*v); sv2=sum(v.*v); %sumatorias cuadraticas
  pend=(n*stv-st*sv)/(n*st2-st^2); %se encuentra la pendiente
  inter=sv/n-pend*st/n; %se encuentra el intercepto
  r2=((n*stv-st*sv)/sqrt(n*st2-st^2)/sqrt(n*sv2-sv^2))^2; %se encuentra el coeficiente de determinacion
  
  printf('\n\tInciso D: Ajuste de regresion lineal simple. \n');
  printf('Pendiente: %4.5f \n',pend);
  printf('Intercepto: %4.5f \n',inter);
  printf('Coeficiente de determinacion: %4.5f \n',r2);
  
  
  %Inciso C y E: Graficas
  %Grafica de los puntos observados y la ecuacion de minimos cuadrados
  xp=linspace(min(t),max(t),2); %ancho de la ventana
  yp=pend*xp+inter;
  plot(t,v,'*',xp,yp);
  grid on;
  title('Diagrama de Dispersion y modelo de Regresion Lineal Simple');
  xlabel('Temperatura (°F)');
  ylabel('Consumo de Vapor');  
  
  %Inciso F: Presentacion de tabla de comparacion
  %generados por un polinomio interpolante de Newton, Lagrange y por Regresion Lineal Simple para cuatro temperaturas.
  printf('\n\tInciso F: Tabla de comparacion de los pronosticos resultantes. ');
  printf('\nIngrese las 4 temperaturas para analizar: \n');
  nt=4;
  for k=1:nt;
    printf('at(%.0f) = ',k);
    at(k)=input(' ');
  endfor
  
  printf('\n\t\t\tTABLA DE COMPARACION');
  printf('\nTemperaturas \tP. Interpolante de \tP. Interpolante de \t Regresion\n');
  printf('\t\t\tNewton\t\t\tLagrange\tLineal Simple\n');
  printf('------------------------------------------------------------------------------------\n');
  for p=1:nt;
    Xint=at(p);
    %Polinomio interpolante de Newton
    n=length(t); %La longitud del vector t nos da el numero de coeficientes y terminos para los polinomios interpolantes
    a(1)=v(1); %aqui se esta encontrando el primer coeficiente del polinomio
    for i=1:n-1;
      divDIF(i,1)=(v(i+1)-v(i))/(t(i+1)-t(i));
    endfor
    for j=2:n-1;
      for o=1:n-j;
        divDIF(o,j)=(divDIF(o+1,j-1)-divDIF(o,j-1))/(t(j+o)-t(o));
      endfor
    endfor
    for s=2:n;
      a(s)=divDIF(1,s-1); %aqui se asignan las diferencias divididas a los coeficientes restantes
    endfor
    YinterN=a(1);
    xn=1;
    for k=2:n;
      xn=xn*(Xint-t(k-1));
      YinterN=YinterN+a(k)*xn; %Respuesta por Newton
    endfor
    
    %Polinomio interpolante de Lagrange
    sum=0;
    for r=1:n;
      producto=v(r);
      for w=1:n;
        if r~=w;
          producto=producto*(Xint-t(w))/(t(r)-t(w));
        endif
      endfor
      sum=sum+producto;
    endfor
    YinterL=sum; %Respuesta por Lagrange
    
    YRegLin=Xint*pend+inter; %Respuesta por Regresion lineal
    printf('%4.2f\t\t %4.5f\t\t\t %4.5f\t\t %4.5f\n',Xint,YinterN,YinterL,YRegLin); %Resultado de la grafica
  endfor
  
endfunction