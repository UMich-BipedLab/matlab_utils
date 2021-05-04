function showBagFileImage(cur_fig, path, name, topic, timestamp)
    if ~exist('topic', 'var') || isempty(topic)
        topic = '/camera/color/image_raw';
    end
    
    if ~exist('timestamp', 'var') || isempty(timestamp)
        timestamp = 1;
    end
    img = loadBagFileImage(path, name, topic, timestamp);
    popCurrentFigure(cur_fig)
    imshow(img)
end