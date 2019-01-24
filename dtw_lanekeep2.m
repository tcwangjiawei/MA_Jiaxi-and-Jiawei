
% Dynamic Time Warping
 % get the distance of signal and reference signal

 function d  = dtw_lanekeep2(~,~,~)
     % S = siganl; R = Reference signal
     % w: window parameter
     % if S(i) is matched with R(j) then |i-j|<=w
     % d: resulting distance
    
      % x1=xlsread('D:\CM7_Highway\Ergebnisse\Car_MA_1023\Ergebnisse-1023.xls','Ergebnisse-1023','B:B');
      S = xlsread('C:\Users\scuwa\Desktop\MA_Jiawei\Data\Ergebnisse-1023.xls','Ergebnisse-1023','A:A');
      % x2=xlsread('D:\CM7_Highway\Ergebnisse\Car_MA_1023\Reference_Signale.xls','Reference_Signale','C4:C800');
      R = xlsread('C:\Users\scuwa\Desktop\MA_Jiawei\Data\Reference_Signale.xlsx','RS_Spurhalten2','A:A');
      
      w = 1000;
  
     
     if nargin<3
         w=Inf;
     end

     %% initialize DTW
     % DTW(i+1,j+1): The accumulated distance between
     %   S(1) to S(i) and R(1) to R(j)
     % M: the length of sequence S
     % N: the length of sequence R
     M = length(S);
     N = length(R);

     DTW = zeros(M+1,N+1);
     w = max([w,abs(M-N)]);

     for i = 2:M+1
         for j =2:N+1
             DTW(i,j) = inf;
         end
     end
     DTW(1,1) = 0;

     %% DTW algorithm
     % d(i,j):The distance between Q(i) = S(i)and C(j)= R(j)
     for i = 2:M+1
         for j = max([2,i-w+1]) : min([N+1,i+w+1])
             d = norm(S(i-1)-R(j-1));
             DTW(i,j) = d+ min([DTW(i-1,j),DTW(i,j-1),DTW(i-1,j-1)]);
         end
     end

     d = DTW(M+1,N+1);
 end