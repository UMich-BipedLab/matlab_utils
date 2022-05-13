function img = loadBagFileImage(path, name, topic, timestamp)
    if ~exist('topic', 'var') || isempty(topic)
        topic = '/camera/color/image_raw';
    end
    
    if ~exist('timestamp', 'var') || isempty(timestamp)
        timestamp = 1;
    end
    bagselect = rosbag(path + name);
    bagselect2 = select(bagselect,'Time',...
        [bagselect.StartTime bagselect.StartTime + 1],'Topic', topic);
    allMsgs = readMessages(bagselect2);
    [img,~] = readImage(allMsgs{timestamp});
end