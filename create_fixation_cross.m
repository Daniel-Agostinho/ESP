function fixation_cross = create_fixation_cross(fixCrossDimPix)

fixation_cross.xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
fixation_cross.yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
fixation_cross.allCoords = [fixation_cross.xCoords; fixation_cross.yCoords];
fixation_cross.lineWidthPix = 4;

end

