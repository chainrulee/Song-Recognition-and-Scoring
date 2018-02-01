% clear all;
% close all;
% clc;

%%
% sec = 13;    
% fs = 44100;
% recorder = audiorecorder(fs, 16, 1);
% display('start recording')
% recordblocking(recorder, sec);
% display('stop recording')
% x = getaudiodata(recorder);
% audiowrite('dreamcatcher(leo).wav',x,fs);
% sound(x,fs);

%%
name = {'worship.mp3', 'heartwall.mp3', 'rainbow.mp3', 'daoshiang.mp3','quiet.mp3', 'countingstars.mp3',...
    'whereshappiness.mp3','asimplesong.mp3','sunnyday.mp3','dreamcatcher.mp3','climb.mp3','PPAP.mp3',...
    'content.mp3','fairytale.mp3','loveexpert.mp3','goodfriend.mp3','invisiblewing.mp3','seeyouagain.mp3',...
    'songfornoone.mp3','suffer.mp3'};
fs = 44100;
% [t{1},fs] = audioread('whereshappiness(leo).wav');

%%
fs2 = 22050;
% [comment{1},fs2] = audioread('excellent.mp3');
% comment{2} = audioread('great.mp3');
% comment{3} = audioread('good.mp3');
% comment{4} = audioread('notbad.mp3');
% comment{5} = audioread('ok.mp3');
% comment{6} = audioread('better.mp3');
% comment{7} = audioread('soso.mp3');
% comment{10} = audioread('notgood.mp3');
% comment{9} = audioread('justsing?.mp3');
% comment{8} = audioread('terrible.mp3');
% comment{11} = audioread('welldone.mp3');

%%
for i = 1:size(name,2)
    [d{i},fs] = audioread(name{i});
    d{i} = d{i}(:,1);
    [~,train{i}] = shrp(d{i},fs,[50 1100]);
end

%%
display(name)
while (1)
    prompt = 'Pick one song and enter the number of its order: ';
    song = input(prompt);
    prompt = 'Do you want to hear the song(yes:1/no:0)? ';
    if input(prompt)
        sound(d{song},fs)
    end
    prompt = 'Are you sure(yes:1/no:0)? ';
    if input(prompt)
        break;
    end
end
% prompt = 'Your voice --> Normal key 1, Low key 0, High key 2: ';
% key = input(prompt);
prompt = 'Press enter to start recording';
input(prompt);

sec = 13;    

fs = 44100;
recorder = audiorecorder(fs, 16, 1);
% sound(d{song},fs)
display('start recording')
recordblocking(recorder, sec);
display('stop recording')
t{1} = getaudiodata(recorder);

[~,test{1}] = shrp(t{1},fs,[50 1100]);
% if key
% elseif key==0
%     test{1} = test{1}*2;
% else
%     test{1} = test{1}/2;
% end

%%
type = 2;
for k = 1:1
%     num = k;
% %     A = conv(test{num},ones(15,1),'same')';
%     A = test{num}';
% %     A = A - mean(A);
%     for j = 1:size(name,2)
% %         B{j} = conv(train{j},ones(15,1),'same')';
%         B{j} = train{j}';
% %         B{j} = B{j} - mean(B{j});
%         [~,~,C(j)] = DTW(A,B{j},type);
% %         B{j} = conv(train{j},ones(15,1),'same')';
% %         B{j} = B{j} - mean(B{j});
% %         C(j) = max(xcorr(A,B{j}));
%     end
%     [M,I] = min(C)
    num = k;
    A = test{num}';
    B = train{song}';
    [~,~,C] = DTW(A,B,type);
    M = C;
%     if song==1
%         M = M/10;
%     end
    if M<47500
        display('Excellent!!! Rank:A+')
        sound(comment{1},fs2)
    elseif M<50000
        display('Well Done!!! Rank:A')
        sound(comment{11},fs2)
    elseif M<52500
        display('Great!!! Rank:A-')
        sound(comment{2},fs2)
    elseif M<55000
        display('Good!!Rank:B+')
        sound(comment{3},fs2)
    elseif M<57500
        display('Not Bad! Rank:B')
        sound(comment{4},fs2)
    elseif M<60000
        display('You can do better Rank:B-')
        sound(comment{5},fs2)
    elseif M<70000
        display('Did you just sing? Rank:C+')
        sound(comment{9},fs2)
    elseif M<80000
        display('You sure you wanna sing? Rank:C-')
        sound(comment{7},fs2)
    elseif M<90000
        display('I give you 87 points, no more Rank:C')
        sound(comment{6},fs2)
    elseif M<100000
        display('I suggest you not sing! Rank:D')
        sound(comment{10},fs2)
    else
        display('Stop now, you hurt my ears Rank:F')
        sound(comment{8},fs2)
    end
        
end
% figure
% plot(A,'g')
% hold
% plot(B{1},'r')
% plot(B{3},'1b')