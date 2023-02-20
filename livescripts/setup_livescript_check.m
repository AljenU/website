function setup_livescript_check(datadir)

parent_directory = fileparts(mfilename("fullpath"));
% Assume location of fieldtrip code next to website code
fieldtrip_directory = fileparts(fileparts(parent_directory));
ft_directory = fullfile(fieldtrip_directory, 'fieldtrip');

% Use a minimal parpool, so not entirely blocked when running test code on
% desktop
parpool(2)

% Add fieldtrip to path
old_dir = pwd();
%addpath(ft_directory)
cd(ft_directory);
ft_defaults()
cd(old_dir);

% Add this dir to path
addpath(parent_directory)

% Switch to dir with the data for the livescript, for running the scripts
cd(datadir)

end