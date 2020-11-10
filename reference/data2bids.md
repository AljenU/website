---
title: data2bids
---
```plaintext
 DATA2BIDS is a helper function to convert MEG, EEG, iEEG or MRI data to the Brain
 Imaging Data Structure. The overall idea is that you write a MATLAB script in which
 you call this function multiple times, once for each individually recorded data
 file (or data set). It will write the corresponding sidecar JSON and TSV files for
 each data file.

 Use as
   data2bids(cfg)
 or as
   data2bids(cfg, data)

 The first input argument 'cfg' is the configuration structure, which contains the
 details for the (meta)data and which specifies the sidecar files you want to write.
 The optional 'data' argument corresponds to preprocessed raw data according to
 FT_DATAYPE_RAW or an anatomical MRI according to FT_DATAYPE_VOLUME. The optional
 data input argument allows you to write preprocessed electrophysiological data
 and/or realigned and defaced anatomical MRI to disk.

 The configuration structure should contains
   cfg.method       = string, can be 'decorate', 'copy' or 'convert', see below (default is automatic)
   cfg.dataset      = string, filename of the input data
   cfg.outputfile   = string, optional filename for the output data (default is automatic)
   cfg.writejson    = string, 'yes', 'replace', 'merge' or 'no' (default = 'yes')
   cfg.writetsv     = string, 'yes', 'replace', 'merge' or 'no' (default = 'yes')

 This function starts from existing data file on disk or from a FieldTrip compatible
 data structure in MATLAB memory that is passed as the second input argument.
 Depending on cfg.method it will add the sidecar files, copy the dataset and add
 sidecar files, or convert the dataset and add the sidecar files. Each of the
 methods is discussed here.

 DECORATE - data2bids will read the header details and events from the data and write
 the appropriate sidecar files alongside the existing dataset. You would use this to
 obtain the sidecar files for data files that are already in the BIDS organization.

 CONVERT - data2bids will read the input data (or use the specified input data) and
 write it to a new output file that is BIDS compliant. The output format is NIfTI
 for MRI data, and BrainVision for EEG and iEEG. Note that MEG data files are stored
 in BIDS in their native format and this function will NOT convert them for you.

 COPY - data2bids will copy the data from the input data file to the output data
 file, which renames it, but does not change its content. Furthermore, it will read
 the header details and events from the data and construct the appropriate sidecar
 files.

 Although you can explicitly specify cfg.outputfile yourself, it is recommended to
 use the following configuration options. This results in a BIDS compliant output
 directory and file name. With these options data2bids will also write, or if
 already present update the participants.tsv and scans.tsv files.
   cfg.bidsroot                = string, top level directory for the BIDS output
   cfg.sub                     = string, subject name
   cfg.ses                     = string, optional session name
   cfg.run                     = number, optional
   cfg.task                    = string, task name is required for functional data
   cfg.datatype                = string, can be any of 'FLAIR', 'FLASH', 'PD', 'PDT2', 'PDmap', 'T1map', 'T1rho', 'T1w', 'T2map', 'T2star', 'T2w', 'angio', 'audio', 'bold', 'bval', 'bvec', 'channels', 'coordsystem', 'defacemask', 'dwi', 'eeg', 'emg', 'epi', 'events', 'exg', 'eyetracker', 'fieldmap', 'headshape', 'ieeg', 'inplaneT1', 'inplaneT2', 'magnitude', 'magnitude1', 'magnitude2', 'meg', 'motion', 'nirs', 'phase1', 'phase2', 'phasediff', 'photo', 'physio', 'sbref', 'stim', 'video'
   cfg.acq                     = string
   cfg.ce                      = string
   cfg.rec                     = string
   cfg.dir                     = string
   cfg.mod                     = string
   cfg.echo                    = string
   cfg.proc                    = string

 When specifying the output directory in cfg.bidsroot, you can also specify
 additional information to be added as extra columns in the participants.tsv and
 scans.tsv files. For example:
   cfg.participants.age        = scalar
   cfg.participants.sex        = string, 'm' or 'f'
   cfg.scans.acq_time          = string, should be formatted according to  RFC3339 as '2019-05-22T15:13:38'
 In case any of these values is specified as empty (i.e. []) or as nan, it will be
 written to the tsv file as 'n/a'.

 For anatomical and functional MRI data you can specify cfg.dicomfile to read the
 detailed MRI scanner and sequence details from the header of that DICOM file. This
 will be used to fill in the details of the corresponding JSON file.
   cfg.dicomfile               = string, filename of a matching DICOM file for header details (default = [])
   cfg.deface                  = string, 'yes' or 'no' (default = 'no')

 You can specify cfg.events as a Nx3 matrix with the trial definition (see
 FT_DEFINETRIAL) or as a MATLAB table. When specified as table, the first three
 columns containing integer values corresponding to the begsample, endsample and
 offset, the additional colums can be of another type and have any name. If you do
 not specify the trial definition, the events will be read from the MEG/EEG/iEEG
 dataset. Events from the trial definition or from the data will be written to
 events.tsv.
   cfg.events                  = trial definition (see FT_DEFINETRIAL) or event structure (see FT_READ_EVENT)

 If NBS Presentation was used in combination with another functional data type, you
 can specify cfg.presentationfile with the name of the presentation log file, which
 will be aligned with the data based on triggers (MEG/EEG/iEEG) or based on the
 volumes (fMRI). Events from the presentation log file will also be written to
 events.tsv. To indicate how triggers (in MEG/EEG/iEEG) or volumes (in fMRI) match
 the presentation events, you should specify the mapping between them.
   cfg.presentationfile        = string, optional filename for the presentation log file
   cfg.trigger.eventtype       = string (default = [])
   cfg.trigger.eventvalue      = string or number
   cfg.trigger.skip            = 'last'/'first'/'none'
   cfg.presentation.eventtype  = string (default = [])
   cfg.presentation.eventvalue = string or number
   cfg.presentation.skip       = 'last'/'first'/'none'

 For EEG and iEEG data you can specify an electrode definition according to
 FT_DATATYPE_SENS as an "elec" field in the input data, or you can specify it as
 cfg.elec or you can specify a filename with electrode information.
   cfg.elec                    = structure with electrode positions or filename, see FT_READ_SENS
 For NIRS data you can specify an optode definition according to
 FT_DATATYPE_SENS as an "opto" field in the input data, or you can specify
 it as cfg.opto or you can specify a filename with optode information.
   cfg.opto                    = structure with optode positions or filename,see FT_READ_SENS

 General BIDS options that apply to all data types are
   cfg.InstitutionName             = string
   cfg.InstitutionAddress          = string
   cfg.InstitutionalDepartmentName = string
   cfg.Manufacturer                = string
   cfg.ManufacturersModelName      = string
   cfg.DeviceSerialNumber          = string
   cfg.SoftwareVersions            = string

 If you specify cfg.bidsroot, this function will also write the dataset_description.json
 file. You can specify the following fields
   cfg.dataset_description.writesidecar        = string
   cfg.dataset_description.Name                = string
   cfg.dataset_description.BIDSVersion         = string
   cfg.dataset_description.License             = string
   cfg.dataset_description.Authors             = string or cell-array of strings
   cfg.dataset_description.Acknowledgements    = string
   cfg.dataset_description.HowToAcknowledge    = string
   cfg.dataset_description.Funding             = string or cell-array of strings
   cfg.dataset_description.ReferencesAndLinks  = string or cell-array of strings
   cfg.dataset_description.DatasetDOI          = string

 General BIDS options that apply to all functional data types are
   cfg.TaskName                    = string
   cfg.TaskDescription             = string
   cfg.Instructions                = string
   cfg.CogAtlasID                  = string
   cfg.CogPOID                     = string

 There are more BIDS options for the mri/meg/eeg/ieegÂ data type specific sidecars.
 Rather than listing them all here, please open this function in the MATLAB editor,
 and scroll down a bit to see what those are. In general the information in the JSON
 files is specified by a field that is specified in CamelCase
   cfg.mri.SomeOption              = string, please check the MATLAB code
   cfg.meg.SomeOption              = string, please check the MATLAB code
   cfg.eeg.SomeOption              = string, please check the MATLAB code
   cfg.ieeg.SomeOption             = string, please check the MATLAB code
   cfg.nirs.SomeOption             = string, please check the MATLAB code
   cfg.coordsystem.someoption      = string, please check the MATLAB code
 The information for TSV files is specified with a column header in lowercase or
 snake_case and represents a list of items
   cfg.channels.someoption         = cell-array, please check the MATLAB code
   cfg.events.someoption           = cell-array, please check the MATLAB code
   cfg.electrodes.someoption       = cell-array, please check the MATLAB code
   cfg.optodes.someoption          = cell-array, please check the MATLAB code

 The implementation in this function corresponds to BIDS version 1.2.0. See
 https://bids-specification.readthedocs.io/ for the full specification and
 http://bids.neuroimaging.io/ for further details.

 See also FT_DATAYPE_RAW, FT_DATAYPE_VOLUME, FT_DATATYPE_SENS, FT_DEFINETRIAL,
 FT_PREPROCESSING, FT_READ_MRI, FT_READ_EVENT
```
