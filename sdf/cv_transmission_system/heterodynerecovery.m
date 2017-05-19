clear all
close all
clc

data=load('translate.txt');
SpS=320;
data(1:SpS*8-SpS/2)=[];

cut=length(data)/SpS-floor(length(data)/SpS);
data(length(data)-cut*SpS+1:length(data))=[];

n=length(data)/SpS;

Data=zeros(n,SpS);

for i=1:n
    Data(i,:)=data(1+(i-1)*SpS:i*SpS);
end

Data([4 5 12 13 20 21 28 29 36 37 44 45 52 53 60 61 68 69 76 77 84 85 92],:)=[];

n=size(Data);
n=n(1);

T=5e-10;
dt=T/SpS;
t=0:dt:dt*(SpS-1);

dt=t(2)-t(1);
dw=2*pi/(SpS*dt);
W=-SpS*dw/2:dw:(SpS/2-1)*dw;
u=zeros(1,length(W));
u(W>1)=1;
u(W>2.5e11)=0;

phase=zeros(1,n);
for i=1:1
    Datafft=fftshift(fft(Data(i,:)));
    Datafftplus=2*u.*Datafft;
    w=W(abs(Datafftplus)==max(abs(Datafftplus)));
    Dataifftplus=ifft(Datafftplus);
    Datadc=Dataifftplus.*exp(-i*w*t);
end

plot(t,real(Dataifftplus),t,real(Datadc))


