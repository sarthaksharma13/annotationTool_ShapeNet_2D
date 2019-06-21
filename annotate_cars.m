% SCRIPT FOR 2D ANNOTATION OF IMAGES

clear all;
close all;
% start and end indices of models to be annotated

% TODO: UPDATE THE VALUES ACCORDING TO THE NUMBERS YOU ARE ASSIGNED
modelStartIdx = 1;
modelEndIdx   = 2;


modelType       = '02958343';
modelDir        = './02958343/';
modelNamesFile  = 'model_names.txt';
numModels       = 1000;
numImages       = 3;
baseNames       = {'a090_e020_t000_d001','a070_e020_t000_d001', 'a110_e020_t000_d001'};

annotationMatName       = 'carWireframePoints2D.mat'
carWireFramePoints2DMat = [];
numKeypoints            = 18;
matIdx                  = 0;
numPointsAnnotated      = 0;

if(exist(annotationMatName,'file') == 2)
    load(annotationMatName);
    matIdx = size(carWireFramePoints2DMat,1) + 1;
else
    matIdx = 1;
    carWireFramePoints2DMat = zeros(1,numImages*numKeypoints,2);
    save(annotationMatName,'carWireFramePoints2DMat');
end

% open the file containing model names
modelNames = fopen(modelNamesFile);

% check if startModelIdx >1
if(modelStartIdx > 1)
    % ignore the models before start idx
    for i = 1:modelStartIdx-1
        fgetl(modelNames);
    end
end



% main loop
for i = modelStartIdx:modelEndIdx
    
    % read all the three images for the model
    model = fgetl(modelNames);
    if(model ~= -1)
        
        for j = 1:numImages
            fig = figure;
            img = imread(strcat(modelDir,model,'/',strcat(modelType,'_',model,'_',baseNames{j}),'.png'));
            
            % start annotation of 18 points for the one half of the car
            imshow(img);
            title(sprintf('Model Number:%d  |  Image Number:%d',i,j));
            dcm_obj = datacursormode(fig);
            
            while(1)
                
                w = waitforbuttonpress;
                if(w == 1)
                    
                    % if SPACE then save the wireframe points
                    if(fig.CurrentCharacter == ' ')
                        a={};
                        f = getCursorInfo(dcm_obj);
                        if(~isempty(f))
                            a = struct2cell(f);
                            
                            if(size(a,3)==numKeypoints)
                                for l=1:numKeypoints
                                    carWireFramePoints2DMat(matIdx,l+numKeypoints*(j-1),:)=a{2,1,l};
                                end
                                save(annotationMatName,'carWireFramePoints2DMat');
                                fprintf('\nKeypoints saved[Model# %d, Image# %d] ...',i,j);
                                break;
                            else
                                fprintf('keypoint selected by you are more or less than specified. hold ALT and selet points');
                            end
                        else
                            fprintf('No Keypoints selected');
                        end
                    end
                end
                
            end
            close all;
        end
        
    else
        fprintf('\nFile Pointer Reached The End');
    end
    matIdx = matIdx + 1;
    
    
    
end
fprintf('\n************* GREAT JOB! *************\n');
fclose(modelNames);
