
%% first transmitter
% we need to enter our music
% we will take the number of secounds needed
fprintf('**********transmitter(1st step)********** .\n\n');
ns=input('please enter the number of the secounds needed  ');
fprintf('here we have looaded our music .\n');
[Y,Fs]=audioread('moonnight.mpeg');
Y=Y(1:ns*Fs,:);
fprintf('the music is playing\n');
sound(Y,Fs);
pause(ns);
fprintf('the music is finished\n ');

% we will plot the signal
fprintf('you will get a graph that has the signal in time domain and in frequency domain \n\n\n');
t= linspace(0,ns,ns*Fs);
figure;
subplot(3,2,1);
plot(t,Y(:,1));
title ('left  in time domain');
subplot (3,2,2);
plot(t,Y(:,2));
title('right in time domain');

% we will transfer it to frequancy domain and plot the magntude and the
% phase
Fvec=linspace (-Fs/2,Fs/2,ns*Fs);
Ys=fftshift(fft (Y));
ymag=abs(Ys);
yphase=angle(Ys)*(180/pi);
subplot(3,2,3);
plot(Fvec,ymag(:,1));
title('left magnitude in the frequency domain');
subplot(3,2,4);
plot(Fvec,ymag(:,2));
title('right magnitude in the frequency domain');
subplot(3,2,5);
plot(Fvec,yphase(:,1));
title('left phase in the frequency domain');
subplot(3,2,6);
plot(Fvec,yphase(:,2));
title('right phase in the frequency domain');


%% secound the channel
% we will chose the type of the response 
fprintf('**********Channel(2nd step)********** .\n\n');
fprintf('A new menu will pop so choose one of the following impulse response\n ');
F=menu('The Impulse Response','delta function','exp(-10000*pi*t)','exp(-2000*pi*t)','2*delta(t)+0.5*delta(t-100)');
switch F 
    case 1
        h_1=zeros (ns*Fs,1);
        h_1(1)=1;
        Yt(:,1)=conv(Y(:,1),h_1);
        Yt(:,2)=conv(Y(:,2),h_1);
    case 2
        h_2=exp(-10000*pi*t);
        Yt(:,1)=conv(Y(:,1),h_2);
        Yt(:,2)=conv(Y(:,2),h_2);
    case 3
       h_3=exp(-2000*pi*t);
        Yt(:,1)=conv(Y(:,1),h_3);
        Yt(:,2)=conv(Y(:,2),h_3);
    case 4
        h_4=zeros (ns*Fs,1);
        h_4(1)=2; h_4(Fs+1)=0.5;
        Yt(:,1)=conv(Y(:,1),h_4);
        Yt(:,2)=conv(Y(:,2),h_4);
end

% we will plot the signal after convolution 
fprintf('you will get a graph that has the signal in time domain .\n');
t=linspace(0,ns,length(Yt(:,1)));
figure;
subplot(1,2,1);
plot(t,Yt(:,1));
title('left signal after response');
subplot(1,2,2);
plot(t,Yt(:,2));
title('right signal after response');

% we will play the sound now after convolution 
fprintf('the convoluted music is playing\n');
sound(Yt,Fs);
pause(ns);
fprintf('the music is finished\n\n\n ');

%% third the noise
% we need the value of the segma 
fprintf('**********NOIS(3rd step)********** .\n\n');
D=Y;
segma=input('please enter the value of the segma in range < 0.1 ');
z=segma*randn(length(D(:,1)),1);
D(:,1)=D(:,1)+z;
D(:,2)=D(:,2)+z;

% we will play the sound now after adding the noise
fprintf('the music is playing aftetr adding noise\n');
sound(D,Fs);
pause(ns);
fprintf('the music is finished\n ');

% we will plot in time domain
fprintf('you will get a graph that has the signal in time domain and in frequency domain \n\n\n');
t= linspace(0,ns,ns*Fs);
figure;
subplot(3,2,1);
plot(t,D(:,1));
title ('left  in time domain');
subplot (3,2,2);
plot(t,D(:,2));
title('right in time domain');

% we will transfer it to frequancy domain and plot the magntude and the
% phase
Fvec=linspace (-Fs/2,Fs/2,ns*Fs);
Ds=fftshift(fft (D));
Dmag=abs(Ds);
Dphase=angle(Ds)*(180/pi);
subplot(3,2,3);
plot(Fvec,Dmag(:,1));
title('left magnitude in the frequency domain');
subplot(3,2,4);
plot(Fvec,Dmag(:,2));
title('right magnitude in the frequency domain');
subplot(3,2,5);
plot(Fvec,Dphase(:,1));
title('left phase in the frequency domain');
subplot(3,2,6);
plot(Fvec,Dphase(:,2));
title('right phase in the frequency domain');

%% fourth the receiver
fprintf('**********Receiver(4th step)********** .\n\n');
l_filter=zeros(ns*Fs,1);

X1=ns*((-3400)-(-Fs/2));
X2=ns*((3400)-(-Fs/2));

l_filter(X1:X2)=1 ;

s=Ds;

s(:,1)=Ys(:,1).*l_filter;
s(:,2)=Ys(:,2).*l_filter;

Sf=real(ifft(ifftshift(s)));

% we will play the sound now after trying to remove the noise
fprintf('the music is playing aftetr trying to remove the noise\n');
sound(Sf,Fs);
pause(ns);
fprintf('the music is finished\n ');

% we will plot in time domain
fprintf('you will get a graph that has the signal in time domain and in frequency domain \n\n\n');
t= linspace(0,ns,ns*Fs);
figure;
subplot(3,2,1);
plot(t,Sf(:,1));
title ('left  in time domain');
subplot (3,2,2);
plot(t,Sf(:,2));
title('right in time domain');

% we will  plot the magntude and the phase
SFmag=abs(s);
SFphase=angle(s)*(180/pi);
subplot(3,2,3);
plot(Fvec,SFmag(:,1));
title('left magnitude in the frequency domain');
subplot(3,2,4);
plot(Fvec,SFmag(:,2));
title('right magnitude in the frequency domain');
subplot(3,2,5);
plot(Fvec,SFphase(:,1));
title('left phase in the frequency domain');
subplot(3,2,6);
plot(Fvec,SFphase(:,2));
title('right phase in the frequency domain');





















