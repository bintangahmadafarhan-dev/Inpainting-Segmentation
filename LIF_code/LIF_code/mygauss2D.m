function G = mygauss2D(width,std)
kernelR = (width-1)/2

G=zeros(width, width);
sum=0.0;
for j = -kernelR:kernelR
    for i = -kernelR:kernelR 
      y=double(j);
      x=double(i);
         Gh=exp(-(x^2+y^2)/(2*std^2))/(2*pi*std^2);
         sum=sum+Gh;
         G(kernelR+j+1,kernelR+i+1)=Gh;
    end
end
G=G/sum;