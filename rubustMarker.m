function [ID,Rvec,Tvec]=rubustMarker
% Ye Tian, Dec. 2016
% close all;
% clear all;
% addpath('Control');
% addpath('Tracking');
% initTracking();

all_info=cell(100,1);
% median_dist=zeros(10,1);
l = length(all_info);
for i=1:l
    markerList = readTrackingMsg();
    num_maker=length(markerList);
    info=zeros(num_maker,8);
    
    
    
    for j = 1:num_maker
        
        marker = markerList(j);
        info(j,1)= marker.ID ;
        info(j,2:4)= marker.Rvec ;
        info(j,5:7)= marker.Tvec ;
        info(j,8)= norm(marker.Tvec)+norm(marker.Rvec);
    end
    
    all_info{i}=info;
%     median_dist(i)=mdeian(dist);
    
end

%  median_dist=sort(all_info{:,2});
%  sort_dist=sort(median_dist);
%  info_num=find(median_dist==sort_dist(5),'first');
%  choose_info=all_info{info_num};
%  ID=choose_info{:,1};
%  Rvec=choose_info{:,2};
%  Tvec=choose_info{:,3};

% times=zeros(6,2);
% for i=1:10
%     Mat=all_info{i};
%     
%     for  j=10:15
%         times(j-9,1)=j;
%         landIndex=findID(j,Mat);
%         if landIndex==[]
%             %         || landIndex==17 || landIndex==18
%             continue;
%         else
%             times(j-9,2)=times(j-9,2)+1;
%         end
%         
%     end
% end

% upFaceIndex=find(times(:,2)==max(times(:,2)));
% upFaceID=times(1,upFaceIndex);
upID=10;

landPos=[];
gripPos=[];
upPos=[];
for i=1:l
    Mat=all_info{i};
    landIndex=findID(18,Mat);
    if length(landIndex)~=0
%         continue;
%     else

    landPos=[landPos;i,Mat(landIndex(1),:)];

    end
    
    gripIndex=findID(17,Mat);
    if length(gripIndex)~=0
%         continue;
%     else

        gripPos=[gripPos;i,Mat(gripIndex(1),:)];

    end
    
    upIndex=findID(upID,Mat);
    if length(upIndex)~=0
%         continue;
%     else

        upPos=[upPos;i,Mat(upIndex(1),:)];

    end
    
    
end

landMedian=findMedian(landPos(:,9));
chooselandPos=landPos(landMedian,:);
gripMedian=findMedian(gripPos(:,9));
choosegripPos=gripPos(gripMedian,:);
upMedian=findMedian(upPos(:,9));
chooseupPos=upPos(upMedian,:);


ID=[chooselandPos(2);choosegripPos(2);chooseupPos(2)];
Rvec=[chooselandPos(3:5);choosegripPos(3:5);chooseupPos(3:5)];
Tvec=[chooselandPos(6:8);choosegripPos(6:8);chooseupPos(6:8)];
% 
% end
 

 

