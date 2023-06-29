clc;clear;


sigma=[0.4 0.6 0.8];
nvar=[20 40 60];
var_max=length(nvar);
sigma_max=length(sigma);
sample_max=25;
e_R=zeros(sigma_max,var_max,sample_max);
e_tw=zeros(sigma_max,var_max,sample_max);
e_thetap=zeros(sigma_max,var_max,sample_max);
td=zeros(sigma_max,var_max,sample_max);


for i_sigma=1:sigma_max

    for i_sample=1:sample_max

        [Ri,ti,ppi,R_truth,tw_truth,thetap_truth]=scaraData(nvar(var_max),sigma(i_sigma));

        for i_n=1:var_max
            Ri_c=Ri(:,:,1:nvar(i_n));
            ti_c=ti(:,1:nvar(i_n));
            ppi_c=ppi(:,1:nvar(i_n));         

            for i=1:1e6
                ;
            end
      
            [R,tw,pw,thetap,td(i_sigma,i_n,i_sample),k_num] = Alg(Ri_c,ti_c,ppi_c);
            [e_R(i_sigma,i_n,i_sample),e_tw(i_sigma,i_n,i_sample),...
                e_thetap(i_sigma,i_n,i_sample)] = evaluation(R_truth,tw_truth,thetap_truth,R,tw,thetap);
        end
    end
end


variableNames   = {'method','variable', 'sample'}';
valueName       = 'Value';
Ta_e_R=mulDimArray2table(e_R, variableNames, valueName);
Ta_e_tw=mulDimArray2table(e_tw, variableNames, valueName);
Ta_e_thetap=mulDimArray2table(e_thetap, variableNames, valueName);
Ta_e_td=mulDimArray2table(td, variableNames, valueName);
save Table Ta_e_R Ta_e_tw Ta_e_thetap Ta_e_td

%13.070416666666702,16.351250000000004,4.500000000000004,6.138333333333296
plotGPA

function [e_R,e_tw,e_thetap] = evaluation(R_truth,tw_truth,thetap_truth,R,tw,thetap)
e_R=norm(vex(logm(R_truth'*R)))*57.3;
e_tw=norm(tw_truth-tw);
e_thetap=norm(thetap_truth-thetap)*57.3;
end
% 13.081,16.361833333333333,5.185833333333331,6.117166666666666

