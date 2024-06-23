clear()

tiempo_fin = 10
Dt = 0.5*1e-4
m=.1;Fr=0.1; l=0.6;g=9.8;M=.5;
u = 0;
pi = %pi;
Xo2 = [0; 0; 3.2 ;0 ]
A2=[[0 0 1 0];...
   [0 -Fr/M -(g*m)/M (m*l*Xo2(4)*Xo2(3))/M];...
   [0 0 0 1 ];...
   [0 Fr/(M*l) ((M+m)*g*Xo2(3))/(M*l) -(m*l*Xo2(4)*Xo2(3))/(M*l)]]
B2=[0; u/M; 0; -u/(M*l)]

cantidad_pasos = tiempo_fin/Dt+1 // determino la cantidad de pasos necesarios para obtener el tiempo tau
t(1) = 0;
X2 = Xo2;
// Integración Euler Forward para el paso elegido
for n = 1: cantidad_pasos -1
  t(n+1) = t(n)+Dt;
  A2=[[0 0 1 0];...
   [0 -(Fr/M) (-1+pi)*(g*m)/M (-X2(3)+pi)*(m*l*X2(4))/M];...
   [0 0 0 1 ];...
   [0 -Fr/(M*l) (-(M+m)*g)/(M*l) (-X2(3)+pi)*(m*l*X2(4))/(M*l)]];
  Xp2(:,n) = A2*X2(:,n)+B2*u;
  X2(:,n+1) = X2(:,n)+Xp2(:,n)*Dt;
end
subplot(221)
plot(t,X2(1,:))
xlabel('tiempo [s]')
ylabel('desplazamiento [m]')
subplot(222)
plot(t,X2(2,:))
xlabel('tiempo [s]')
ylabel('velocidad [m]')
subplot(223)
plot(t,X2(3,:))
xlabel('tiempo [s]')
ylabel('angulo barrido [rad]')
subplot(224)
plot(t,X2(4,:))
xlabel('tiempo [s]')
ylabel('velocidad angular [rad/s]')
