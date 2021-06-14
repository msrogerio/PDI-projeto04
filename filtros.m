%% Projeto 03
% *Autor:* Marlon da Silva Rogério

%% Referências
% *GONZALEZ, R. C.*, WOODS, R. E. Processamento de Imagens Digitais. 
% Editora Edgard Blucher, ISBN São Paulo, 2000.
% *Support MathWorks*, 2021. Disponível em: <https://www.mathworks.com/help/>.
% Acesso em: 22 de maio. de 2021.
% Txh, Q. R. and Ilowurv, V. ([S.d.]). Filtros Compostos e Adaptativos. p. 1–20. 

close all; clear; clc;

%% 1 Filtros (Definições)
% - *Filtro passa-baixas:* Suaviza a imagem atenuando as altas freqüências, 
% que correspondem às transições abruptas. Tende a minimizar ruídos e 
% apresenta o efeito de borramento da imagem.   
% - *Filtro passa-altas:* a filtragem passa-alta realça detalhes, produzindo 
% uma "agudização" ("sharpering") da imagem, isto é, as transições entre 
% regiões diferentes tornam-se mais nítidas.
% - *Filtro passa-faixa:* permite a passagem das frequências localizadas 
% em uma faixa ou banda específica, enquanto atenua ou completamente suprime 
% todas as outras frequências.
% - *Filtro rejeita-faixa:* atenua as frequências localizadas em uma faixa 
% ou banda específica, enquanto permite a passagem de todas as outras
% frequências.

img_passa_altas = imread('passa_altas.png');
figure;
imshow(img_passa_altas);
title('Fitro passa-altas');

%% 1.1 Filtros (Aplicação)
% Aplicar em 3 imagens imagens que tem a necessidade de filtrar na 
% frequência para alguma aplicação. Teste e comente.

% *PASSA-ALTAS*
% f_original = imread('lab.bmp');
%f_original = imread('mulher.jpeg');
f_original = imread('operacao.jpeg');
f_original = rgb2gray(f_original);
figure; 
subplot(1,2,1);
imshow(f_original,[]); 
title('Imagens Original');
subplot(1,2,2);
imhist(f_original);
title('Histograma da Img Original');

%% 
f=double(f_original);
F = fft2(f);
F_norm = fftshift(F);
J = 1*log(1+abs(F_norm));
figure; imshow(J,[])

[M , N] = size(f);

x=linspace(-5,5,N);
y=linspace(-5,5,M);

%% 
[X,Y]=meshgrid(x,y);
formula=imread('form_gauss.png');
figure;
subplot(1,2,1);
imshow(formula, []);
title('Equação isotrópica em 2-D da função Gaussiana');
z=(3.9/sqrt(2*pi).*exp(-(X.^2/2)-(Y.^2/2)));
z2= 1.1569-z;
subplot(1,2,2);
surf(X,Y,z2);
shading interp
axis tight

H = fftshift(z2);
G = F.*H;
g = ifft2(G);

figure; 
subplot(1,2,1);
imshow(g,[]); 
title('Aplicação do filtro passa-altas');

G_norm = fftshift(G);
J = 1 * log (1 + abs(G_norm));
subplot(1,2,2);
imshow(J,[]);
title('Espectro da frequência');

%% 2 Notch (Definição)
% - *Filtro notch:* filtragem notch é usada para eliminar efeitos de ruídos 
% periódicos(filtros notch são filtros capazes de rejeitar uma faixa bastante 
% estreita de freqüências,assim sua utilização é recomendada quando o sinal a 
% ser atenuado é bem definido). 


%% 2.1 Notch (Aplicação)
% Aplicar na imagem ao lado, para remover o efeito Moiré 
% O chamado *efeito moiré* é uma interferência gerada quando tentamos visualizar 
% – numa televisão, por exemplo – um padrão através de outro.

close all; clear; clc;
moire = imread('moire.jpeg');
imshow(moire);
title('Conceito de Moiré');

f = imread('carro.bmp');
f = rgb2gray(f);

figure; 
subplot(1,2,1);
imshow(f,[]);
title('Imagem Original')
subplot(1,2,2);
imhist(f);
title('Histograma Img Original');

F = fft2(f);
F = fftshift(F);
J = 1 * log (1 + abs(F));
figure;
subplot(1,2,1);
imshow(abs(F),[]);
title('Trasnformada normalizada');
subplot(1,2,2);
imshow(abs(J),[]);
title('Log da trasnformada normalizada');

[M,N]=size(f);
H =ones(M,N);

centros = [56 86  10; 112  82 10; 112  41 10; 55 45  10;
           58 166 10; 114 162 10; 115 203 10; 58 207 10 ];

%out = idealHighpassFilter( 25, 25, 10 );  
out = gaussianHighpassfilter( 25, 25, 5 );  

[m,n]=size(out);

for index = 1:8
    col = floor(centros(index,1)-n/2);
    row = floor(centros(index,2)-m/2);
    H(row:row+m-1 , col:col+n-1) = out;    
end

figure;
subplot(1,2,1);
imshow(H,[])
title('Centros alinhados à frequência');
G = J.*H;
subplot(1,2,2);
imshow(G,[]);
title('Centros alinhados à frequência sob o espctro');

G = F.*H;
frec = ifft2(fftshift(G));
figure;
subplot(1,2,1);
imshow(f,[]);
title('Imagem Original');
subplot(1,2,2);
imshow(frec,[])
title('Imagem trabalhada - Efeito Moiré retirado');
