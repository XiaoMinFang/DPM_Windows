function getfil(matfile,tagdir)

%   matfile = 'E:\code\dpm\voc-release4.01vts\TrainVal\pede_final_add_56_112.mat';
    matfile = 'E:\DPM_train_code\TrainVal\result\pede_final.mat';
    tagdir = 'E:\DPM_train_code\TrainVal\pede\';
    load (matfile);
    cachedir = [tagdir '\profiles\'];
    if exist(cachedir,'dir') == 0
        cur_dir = cd();
        cd(tagdir);
        system(['md ' 'profiles']);
        cd(cur_dir);
    end
    rulesn = numel(model.rules{1,2});
    txtn = 1;
    while(exist(sprintf('%s/profiles/1 (%d).txt',tagdir,txtn)))
        txtn = txtn + 1;
    end
    for i = 1:rulesn
        filterrow = [];
        for ii = model.rules{1,2}(1,i).rhs
            filterrow = [filterrow model.symbols(1,model.rules{1,ii}.rhs).filter];
        end
        for j = 1:numel(filterrow)
            fid=fopen(sprintf('%s/profiles/1 (%d).txt',tagdir,txtn),'w');
            txtn = txtn + 1;
            for dim=1:32
                fprintf(fid,'%f ',model.filters(1,filterrow(j)).w(:,:,dim)');
            end
            fclose(fid);
        end
    end
    fid = fopen(sprintf('%s/profiles/vts_def.txt',tagdir),'a');
    for i = 1:rulesn
        for irhs = model.rules{1,2}(1,i).rhs
            for j = 1:4
                fprintf(fid,'%f\t',model.rules{1,irhs}.def.w(j));
            end
            fprintf(fid,'\n');
        end
        fprintf(fid,'\n');
    end
    fclose(fid);
    fid = fopen(sprintf('%s/profiles/vts_anchor.txt',tagdir),'a');
    for i = 1:rulesn
        for anchori = 1:numel(model.rules{1,2}(1,i).anchor)
            an = model.rules{1,2}(1,i).anchor{1,anchori};
            fprintf(fid,'%d\t%d\t%d\n',an(1),an(2),an(3));
        end
        fprintf(fid,'\n');
    end
    fclose(fid);
    fid = fopen(sprintf('%s/profiles/vts_size.txt',tagdir),'a');
    for i = 1:rulesn
        fprintf(fid,'%d %d ',model.rules{1,2}(1,i).detwindow(1),model.rules{1,2}(1,i).detwindow(2));
        for j = 2:numel(model.rules{1,2}(1,i).rhs)
            fprintf(fid,'6 6 ');
        end
        fprintf(fid,'\n');
    end
    fclose(fid);
    fid = fopen(sprintf('%s/profiles/vts_thresh.txt',tagdir),'a');
    for i = 1:rulesn
        fprintf(fid,'%f\n',model.thresh-model.rules{1,2}(1,i).offset.w);
    end
    fclose(fid);
end