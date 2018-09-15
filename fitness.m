function TEM=fitness(length)
%function fitness(length,Lambda,cp,rou,qw,xspan,tspan,ngrid)
%%%%%%%%%%%%%
%��Ҫ��������Բ��� �������demo һ���
Lambda=0.045;%����ϵ��
cp=1726;%����
rou=74.2;%�ܶ�
%%%%%%%%%%%%%
a=Lambda/rou/cp;%�����м�ϵ��
xspan=[0 length];%����������ֹλ��
tspan=[0 50];%����ʱ����ֹ
ngrid=[1000 20];%�ռ���������ʱ��������
%%%%%%%%%%%%%
%�����Ӻ���
[T,x,t]=rechuandao(a,xspan,tspan,ngrid);
%��ͼ
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
% �ȴ������̣�
% Ut(x,t)=c^2*Uxx(x,t) a<x<b ts<t<tf
%һά����̬���ȷ���
% ����˵��
% f����ֵ����
% g1,g2����ֵ����
% xspan=[a,b]��x��ȡֵ��Χ
% tspan=[ts,tf]��t��ȡֵ��Χ
% ngrid=[n,m]������������mΪx�����������nΪt�����������
% U�����̵���ֵ��
% x,t��x��t�������
n=ngrid(1);
m=ngrid(2);
h=range(xspan)/(m-1);
x=linspace(xspan(1),xspan(2),m);
k=range(tspan)/(n-1);
t=linspace(tspan(1),tspan(2),n);
r=a*k/h^2;%%
if r>0.5
error('Ϊ�˱�֤�㷨�����������󲽳�h���С����k')
end
%�����м�ϵ��
s=1-2*r;
U=zeros(ngrid);%��������ֵ
% ��ֵ����������һ�����³�����ط�Ӧ�������� ���Ľ�
U(1,:)=37;
% ��ּ���
for j=2:n
for i=2:m-1
U(j,i)=s*U(j-1,i)+r*(U(j-1,i-1)+U(j-1,i+1));
end
%%%%%%%�����Ǳ߽�����
U(j,1)=50;
U(j,m)=U(j,m-1);%���ȱ߽�����
end