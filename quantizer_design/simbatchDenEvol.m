close all;
% clear all;

parallel = false;

Nb_Msg = 3;
Nb_Cha = 3;
dv=6;
dc=32;
sw = [0.1,1];



Nb = combvec(Nb_Msg, Nb_Cha);
Nq = 2.^Nb;
precision = 1e-5;  %of threshold
BER_target = 1e-8;
max_dec_it = 100;
max_bisec_it = 60;
cnmethod = 'minsum';
vnmethod = 'tree';
quant_method = 'maxMIsym';


sigma_th = zeros(1,size(Nq,2));

%%  Load predefined VN structure if necessary

vnroot  =  VNode_06_04();
decroot =  VNdec_06_03();
cnroot = [];

%% Run Density Evolution
if parallel
    matlabpool open;
    for ii=1:size(Nq,2)
        sigma_th(ii) = densityEvolutionBIAWGN( ones(1,max_dec_it)*Nq(1,ii), Nq(2,ii), dv, dc, sw, precision, BER_target,  max_dec_it, max_bisec_it,quant_method, cnmethod, vnmethod, cnroot, vnroot, decroot);
    end
    matlabpool close
else
    for ii=1:size(Nq,2)
        sigma_th(ii) = densityEvolutionBIAWGN( ones(1,max_dec_it)*Nq(1,ii), Nq(2,ii), dv, dc, sw, precision, BER_target,  max_dec_it, max_bisec_it,quant_method, cnmethod, vnmethod, cnroot, vnroot, decroot);
    end
end


%% Plot
legend_cell = cell(length(Nb_Msg)+1,1);
sigma_mat = zeros(length(Nb_Cha),length(Nb_Msg));
for kk=1:length(Nb_Cha)
   sigma_mat(kk,:) = sigma_th(length(Nb_Msg)*(kk-1)+1:kk*length(Nb_Msg));
end
for kk= 1:length(Nb_Msg)
    legend_cell{kk} =sprintf('N_q^{(Msg)} = %d',2^Nb_Msg(kk));
end
legend_cell{kk+1} = 'AWGN Threshold';

EbN0_th =    -10*log10(2*sigma_mat.^2* (1-dv/dc) ); 

figure(1);
hold on;
plot(2.^repmat(Nb_Cha.', [1 length(Nb_Msg)]),  sigma_mat.^2);
xlabel('N_q^{(Cha)}');
ylabel('Noise Threshold \sigma^2');   
grid on;
plot(2.^Nb_Cha,  0.88^2*ones(length(Nb_Cha)), 'k--');
legend(legend_cell, 'Location', 'SouthEast');
% set(gca,'xscale','log');
axis( [2^min(Nb_Cha), 2^max(Nb_Cha),0.1,0.8]);
hold off;


%% Save
% save('~/Density_Evolution_Tree_MinsumCN_MaxEntr');