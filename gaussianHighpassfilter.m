function out = gaussianHighpassfilter( M,N, sigma )
%GAUSSHIGHPASSFILTER: Construction frequency domain Gaussian low pass filter
% I: input image
% sigma: sigma parameter of Gaussian function
% out: return value

%[M, N] = size(I);

out = ones(M,N);
for i = 1:M
    for j = 1:N
        out(i,j)=1-exp(-((i-M/2)^2+(j-N/2)^2)/2/sigma^2);
    end
end

