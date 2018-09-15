function TEM=fitness(length)
%function fitness(length,Lambda,cp,rou,qw,xspan,tspan,ngrid)
%%%%%%%%%%%%%
%需要输入的物性参数 这个就是demo 一层的
Lambda=0.045;%导热系数
cp=1726;%热容
rou=74.2;%密度
%%%%%%%%%%%%%
a=Lambda/rou/cp;%定义中间系数
xspan=[0 length];%轴向坐标起止位置
tspan=[0 50];%仿真时间起止
ngrid=[1000 20];%空间网格数和时间网格数
%%%%%%%%%%%%%
%调用子函数
[T,x,t]=rechuandao(a,xspan,tspan,ngrid);
%画图
[x,t]=meshgrid(x,t);
% figure(1)
% mesh(x,t,T);
% xlabel('x')
% ylabel('t')
% zlabel('T')
% figure(2)
% plot(t(:,20),T(:,20));
% ylabel('t')
% zlabel('T')
%TEM=T(1000,20)

TEM=abs(T(1000,20)-45)

function [U,x,t]=rechuandao(a,xspan,tspan,ngrid)
% 热传导方程：
% Ut(x,t)=c^2*Uxx(x,t) a<x<b ts<t<tf
%一维非稳态导热方程
% 参数说明
% f：初值条件
% g1,g2：边值条件
% xspan=[a,b]：x的取值范围
% tspan=[ts,tf]：t的取值范围
% ngrid=[n,m]：网格数量，m为x网格点数量，n为t的网格点数量
% U：方程的数值解
% x,t：x和t的网格点
n=ngrid(1);
m=ngrid(2);
h=range(xspan)/(m-1);
x=linspace(xspan(1),xspan(2),m);
k=range(tspan)/(n-1);
t=linspace(tspan(1),tspan(2),n);
r=a*k/h^2;%%
if r>0.5
error('为了保证算法的收敛，增大步长h或减小步长k')
end
%两个中间系数
s=1-2*r;
U=zeros(ngrid);%初步赋初值
% 初值条件，给了一个均温场这个地方应该有问题 待改进
U(1,:)=37;
% 差分计算
for j=2:n
for i=2:m-1
U(j,i)=s*U(j-1,i)+r*(U(j-1,i-1)+U(j-1,i+1));
end
%%%%%%%下面是边界条件
U(j,1)=50;
U(j,m)=U(j,m-1);%绝热边界条件
end