
export SLAC_ST_BUILD=false
export PIP_DEPS='coverage pytest-cov'
export CONDA2='conda install -y -c conda-forge healpy'
export INSTALL_CMD='python setup.py install'
export CONDA_CHANNELS="conda-forge"
export CONDA_DEPS='gammapy numpy astropy scipy matplotlib pytest pyyaml'
#export CONDA_DEPS='pytest pyyaml'
export CONDA_PATH='/u/ek/echarles/dmcat/software/build_test/miniconda'

NAME='main'


case $NAME in
    main)
	export PYTHON_VERSION="2.7"
	export CONDA_DOWNLOAD="Miniconda2-latest-Linux-x86_64.sh"
	export ST_INSTALL="conda install -y -c conda-forge -c conda-forge/label/cf201901 -c fermi fermitools"
	;;
    old)
	export PYTHON_VERSION="2.7"
	export CONDA_DOWNLOAD="Miniconda2-latest-Linux-x86_64.sh"
	export ST_INSTALL="conda install -y -c conda-forge/label/cf201901 -c fermi fermitools=1.0.2"
	;;
    veryold)
	export PYTHON_VERSION="2.7"
	export CONDA_DOWNLOAD="Miniconda2-latest-Linux-x86_64.sh"
	export ST_INSTALL="conda install -y -c conda-forge/label/cf201901 -c fermi fermitools=1.0.0"
	;;
    ancient)
	export PYTHON_VERSION="2.7"
	export CONDA_DOWNLOAD="Miniconda2-latest-Linux-x86_64.sh"
	export ST_PATH='/u/ek/echarles/dmcat/software/build_test'
	export ST_INSTALL="bash stinstall.sh $ST_PATH"
	export FERMI_DIR='/u/ek/echarles/dmcat/software/build_test/ScienceTools/x86_64-unknown-linux-gnu-libc2.17'
	export CONDA_DEPS='gammapy numpy astropy scipy matplotlib pytest pyyaml'
	;;
    docs)
	export PYTHON_VERSION="3.6"
        export ST_INSTALL=''
        export DOCKER_INSTALL=''
        export PIP_DEPS='coverage pytest-cov coveralls sphinx sphinx_rtd_theme'
	export CONDA_DOWNLOAD='Miniconda3-latest-Linux-x86_64.sh'
        export CONDA_DEPS='gammapy numpy astropy scipy matplotlib pytest pyyaml sphinx sphinx_rtd_theme'
	;;
    py36_st-no_dep-yes)
	export PYTHON_VERSION="3.6"
        export ST_INSTALL=''
        export DOCKER_INSTALL=''
	export CONDA_DOWNLOAD='Miniconda3-latest-Linux-x86_64.sh'
	;;
    py2_st-no_dep-yes)
	export PYTHON_VERSION="2.7"
        export ST_INSTALL=''
        export DOCKER_INSTALL=''
	export CONDA_DOWNLOAD='Miniconda2-latest-Linux-x86_64.sh'
	;;
    slac*)
	export PYTHON_VERSION="2.7"
	export CONDA_DOWNLOAD="Miniconda-latest-Linux-x86_64.sh"
	export ST_INSTALL=""
	export SLAC_ST_BUILD=true
	export INST_DIR='/u/ek/echarles/dmcat/software/git-releases/FT_01-00-01_orig'
	;;
esac

echo Running fake_travis for build $NAME

\rm -rf $CONDA_PATH
source condainstall.sh 

bash travistests.sh

coveralls --rcfile='fermipy/tests/coveragerc'
