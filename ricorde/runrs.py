'''
Functions for running RICorDE workflows
'''
import os

 
 
from definitions import proj_dir
from hp.basic import get_dict_str
import configparser
from definitions import config_params


def load_params(param_fp,
                config_params=config_params,
                ):
    """
    Load RICorDE run parameters from a config file
    
    Parametersd
    ----------
    param_fp : str
        Filepath to parameter file
    config_params : dict, default Session.config_params
        parameters for the configarser {sectionName:{varName:(mandatory_flag, ConfigParser get method)}}
        defaults to Session
 
 
    """
    
    #===========================================================================
    # init the parser
    #===========================================================================
    assert os.path.exists(param_fp), param_fp
    
    parser=configparser.ConfigParser(inline_comment_prefixes='#')
    parser.read(param_fp)
    
    #===========================================================================
    # check parameter file
    #===========================================================================
    for sectName, sect in parser.items():
        if sectName =='DEFAULT': 
            continue
        assert sectName in config_params, 'got unrecognized section name \'%s\''%sectName
        for varName, var in sect.items():
            assert varName in config_params[sectName], 'got unrecognized variable: \'%s.%s\''%(sectName, varName)
            #print('%s.%s'%(sectName, varName))
    
    #===========================================================================
    # load usin the parameters
    #===========================================================================
    cnt = 0
    res_lib = {k:dict() for k in config_params.keys()}  #results congainer
    for sectName, d in config_params.items():
        assert sectName in parser.sections(), '%s missing from parameter file'%sectName
        for varName, (required, method) in d.items():
            #print('%s.%s: required=%s, method=%s'%(sectName, varName, required, method))
            
            #check if the parameter is in the file
            if varName in parser[sectName]:
                f = getattr(parser, method)
                val = f(sectName, varName)
                if val in ['']:
                    assert not required, '%s.%s is required but was passed empty'%(sectName, varName)
                else:
                    res_lib[sectName][varName] = val
 
                    
                cnt+=1
            else:
                assert not required, '%s.%s is required and not found in the parameter file'%(sectName, varName)
            
    print('retrieved %i parameters from file\n%s'%(cnt, get_dict_str(res_lib)))
    
    return res_lib


def run_from_params(
                #parameter inputs and file
                param_fp=os.path.join(proj_dir, 'params_default.txt'),
                param_lib=None,
                
                **kwargs):
    """execute a RICorDE workflow from a parameter file
    
    Parameters
    ----------
    param_fp : str
        Filepath to parameter file. Defaults to the params_default.txt found in the project
    param_lib : dict, optional
        Override loading from file and use the passed parameters (mainly for testing)
        
    Returns
    ----------
    str
        Directory where outputs are written
    dict
        Keyed output filepaths
        
    Notes
    -----------
    parameters passed in the 'session' section will be passed as kwargs to the  __init__ cascade.
    Other sections will be passed in 'bk_lib'
    
    """
    #load from teh parameter file
    if param_lib is None:
        param_lib = load_params(param_fp)
    
    #extract special parameters
    d = param_lib.pop('session')
    session_kwargs = {k:v for k,v in d.items() if not v==''} #clear empties
    print('running w/ \n%s\n\n'%get_dict_str(session_kwargs))
    

    #initilze the calculation session using these parameters
    from ricorde.scripts import Session
    with Session(            
                  
            bk_lib = param_lib,            
            #session_kwargs
            #crsid=QgsCoordinateReferenceSystem(crsid),
            #aoi_fp=aoi_fp, dem_fp=dem_fp, inun_fp=inun_fp, pwb_fp=pwb_fp, #filepaths for this project
            **{**session_kwargs, **kwargs}
            ) as wrkr:
        wrkr.logger.info('\n\n start calc sequence\n\n')
        wrkr.run_dataPrep()
        wrkr.run_HAND()
        wrkr.run_imax()
        wrkr.run_HANDgrid()
        wrkr.run_wslRoll()
        wrkr.run_depths()
        
        outputs = wrkr.out_dir, wrkr.ofp_d
        
    return outputs



 
