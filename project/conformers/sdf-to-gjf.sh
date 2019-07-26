#Write all conformers from .sdf out as .gjf files

obabel -isdf CONF.sdf -ogjf -Oconf-.gjf -m -xf header.txt
