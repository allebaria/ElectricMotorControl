t=pertsinus.t;
y=pertsinus.y;
[pks,locs] = findpeaks(y);
tpeaks=[];
s=size(locs);
for i=1:(s(1)-1)
    tpeaks(i)=t(locs(i+1))-t(locs(i));
end
freq=2*pi*(1/(mean(tpeaks)/1000000))