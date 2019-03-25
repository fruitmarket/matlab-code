function merge2Ntt(newfn, file1, file2)
copyfile(file1,newfn);
newfid = fopen(newfn,'a','b');
f2 = fopen(file2, 'r','b');
fseek(newfid,0,'eof');
fseek(f2,16384,'bof');
f2_data = fread(f2,'uint8');
fwrite(newfid,f2_data,'uint8');
fclose(newfid);
fclose(f2);