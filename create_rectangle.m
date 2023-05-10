function rectangle = create_rectangle (newCent, pixelsX, pixelsY, config)
    
    xCenter = config.xCenter; yCenter = config.yCenter;
    
    rectangle.newCent = -50; % centro do retangulo para variável y
    rectangle.pixelsY= 400;
    rectangle.pixelsX= 275;
    rectangle.textureRect= CenterRectOnPointd([0 0 pixelsX pixelsY],xCenter,yCenter-newCent);
    rectangle.center = [xCenter yCenter];
    
end