
rootdir = fileparts(fileparts(mfilename("fullpath")));

% Assume livescript2markdown from the matlab file exchange is available
% here:
addpath(fullfile(rootdir, '\livescripts\util\livescript2markdown-master\function'));

% More of the below could be automated, but this at least documents the steps

% - Clean all output from the livescript
% - Export livescript as latex
% (Look at .... for possibilities of automating this)

% latex to markdown
infile = fullfile(rootdir, 'livescripts','util', 'parfor_eventrelatedaveraging.tex');
outfile_no_ext = fullfile(rootdir, 'tutorial', 'parfor_eventrelatedaveraging');
mdfile = latex2markdown(infile, 'outputfilename', outfile_no_ext);

outfile = [outfile_no_ext, '.md'];
md_contents = fileread(outfile);

% - exercises in boxes as: #### Exercise 1 \n\n {% include markup/info %} stuff here {% include markup/end %}
md_contents = strrep(md_contents, '%box%', '{% include markup/info %}');
md_contents = strrep(md_contents, '%box-end%', '{% include markup/end %}');

fid = fopen(outfile, 'wt');
fprintf(fid, '%s', md_contents);
fclose(fid);

% adapt markdown to fieldtrip tutorial standards (could be included in latex2markdown)
% - title and tags at the top in special area
% - check title is #, other headings are ## mostly
% - remove table-of-content (?)
% - relative links to other parts of website