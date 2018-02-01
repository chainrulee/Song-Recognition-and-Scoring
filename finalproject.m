% clear all;
% close all;
% clc;

%%
[d1,fs] = audioread(strcat('./train/','red.mp3'));
[d2,fs] = audioread(strcat('./train/','shake it off.mp3'));
% [d3,fs] = audioread(strcat('./train/','flower.mp3'));
d1 = d1(:,2);
d2 = d2(:,2);
% d3 = d3(:,1);


% using MATLAB spectrogram(), note that Spectral Doppler need to show the negative frequency part but spectrogram() does not show!!! 
[train{2}, ~, ~] = spectrogram(d2, hamming(10000), 7500, 10000, fs); % example
train{2} = abs(train{2});
train{2} = imregionalmax(floor(train{2}/(max(max(train{2}))*0.2)));
% train{2}(1:25,:)=0;
% train{2} = max(abs(train{2}));
[train{1}, F, t] = spectrogram(d1, hamming(10000), 7500, 10000, fs);
train{1} = abs(train{1});
train{1} = imregionalmax(floor(train{1}/(max(max(train{1}))*0.2)));
% train{1}(1:25,:)=0;
% train{1} = max(abs(train{1}));
% [train{3}, ~, ~] = spectrogram(d3, hamming(2000), 500, 2000, fs); % example
% display, I just copy the sample codes of MATLAB spectrogram()
% surf(t,F,20*log10(abs(S)),'EdgeColor','none');
% axis xy; axis tight; colormap(gray); view(0,90);
% xlabel('Time (sec)');
% ylabel('Frequency (Hz)');
% title('Matlabspectrogram S');
%% MFCC
% train{2} = MFCC(strcat('./train/','shake it off.mp3'));
% train{1} = MFCC(strcat('./train/','red.mp3'));

% for i = 1:40
%     test{i} = MFCC(strcat('./test/u',num2str(i-1),'.wav'));
% end

sec = 13;    
% fs = 44100;
recorder = audiorecorder(fs, 16, 1); 
display('start recording')
recordblocking(recorder, sec); 
display('stop recording')
x = getaudiodata(recorder);
% sound(x,fs);
% test{1} = MFCC(x);
[test{1}, ~, ~] = spectrogram(x, hamming(10000), 7500, 10000, fs);
test{1} = abs(test{1});
test{1} = imregionalmax(floor(test{1}/(max(max(test{1}))*0.1)));
% test{1}(1:25,:)=0;
% test{1} = max(abs(test{1}));

type = 2;
% out = zeros(40,2);
% err = 0;
for k = 1:1
    num = k;
    for j = 1:2
        [~,~,C(j)] = DTW(test{num},train{j},type);
    end
%     C = abs(C);
    [M,I] = min(C)
%     if I-1 ~= floor((k-1)/4)
%         err = err + 1;
%     end    
%     out(k,:) = [I-1,floor((k-1)/4)];
end


