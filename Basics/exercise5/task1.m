%% Reads the image
img = imread('resources\noisylena.tiff');

%% Forming the low-pass filter value D.

sy = size(img,1)/2;
sx = size(img,2)/2;

x = -(sx-1):sx;
y = -(sy-1):sy;

[X, Y] = meshgrid(x,y);

D = sqrt(X.^2 + Y.^2);

% test if the D seems right.
figure; imshow(D,[]);

Do = 50;
Hi = D <= Do;

%% Butterworth H:

Butt = zeros(size(img,1),size(img,2),12);

figure(1);
for n = 1 : 12
    colormap jet; colorbar; hold on;
    H = 1./(1+(D/Do).^(2*n));
    
    M = H(size(H,1)/2,:);
    
    plot(M);
    xlabel("D(u,v)");
    ylabel("H(u,v)");
    
    Butt(:,:,n) = H;
end
plot(Hi(size(Hi,1)/2,:),'black');
legend("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "Ideal");

%% Gaussian H:

Gauss = zeros(size(img,1), size(img,2), 9);

Do = 10;
figure(2);
for n = 1 : 9
    colormap jet; colorbar; hold on;
    H = exp(-D.^2 /(2*Do^2));
    
    M = H(size(H,1)/2,:);
    
    plot(M);
    xlabel("D(u,v)");
    ylabel("H(u,v)");

    Do = Do + 10;
    
    Gauss(:,:,n) = H;
end

plot(Hi(size(Hi,1)/2,:),'black');
legend("10","20","30","40","50","60","70","80","90", "Ideal");
