#!/usr/bin/env bash

set -x
basedir='/lustre/storeB/project/fou/kl/admaeolus/'
datadir="${basedir}data.rev.2A02/"
downloaddir="${datadir}download/"
downloaddir="${datadir}download/AE_TD01_ALD_U_N_2A_20181120T144402034_005448000_001423_0001/"
downloaddir="${datadir}download/2018-11/"
#netcdfdir="${datadir}netcdf/"
netcdfdir="${datadir}netcdf_emep_domain/"

jobfile="./2A02_201811_emep.run.txt"
rm -f "${jobfile}"

mkdir -p "${netcdfdir}"
for file in `find ${downloaddir} -name '*ALD_U_N_2A*.TGZ' | sort`
    do echo ${file}
    cmd="./read_aeolus_l2a_data.py --emep --outdir ${netcdfdir} --plotmap --plotprofile --tempdir /tmp/ --file ${file}"
    echo ${cmd}
    echo ${cmd} >> "${jobfile}"
done

# command to start using gnu parallel
# /usr/bin/parallel -vk -j 4 -a 2A02.run.txt