function visualizemode(Ex,Ey,x,y,edges,neff)

% visualizemode
figure;
colormap(jet(256));
subplot(121);
imagemode(x,y,Ex);
title(['Ex (for TE mode) neff=' num2str(neff,'%.5f')]); xlabel('x(\mum)'); ylabel('y(\mum)');
line(edges{:});
subplot(122);
imagemode(x,y,Ey);
title(['Ey (for TM mode) neff=' num2str(neff,'%.5f')]); xlabel('x(\mum)'); ylabel('y(\mum)');
line(edges{:});

end

