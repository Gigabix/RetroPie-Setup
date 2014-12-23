rp_module_id="dgen"
rp_module_desc="Megadrive/Genesis emulat. DGEN"
rp_module_menus="2+"

function depends_dgen() {
    checkNeededPackages libsdl1.2-dev libarchive-dev
}

function sources_dgen() {
    wget -O- -q http://sourceforge.net/projects/dgen/files/dgen/1.33/dgen-sdl-1.33.tar.gz/download | tar -xvz --strip-components=1
}

function build_dgen() {
    ./configure --disable-opengl --disable-hqx --prefix="$md_inst" CFLAGS="$CFLAGS --param ggc-min-expand=0 --param ggc-min-heapsize=8192"
    make clean
    make
    md_ret_require="$md_build/dgen"
}

function install_dgen() {
    make install
    md_ret_require="$md_inst/bin/dgen"
}

function configure_dgen()
{
    if [[ ! -f "$configdir/all/dgenrc" ]]; then
        mkdir -p "$configdir/all/"
        cp "$md_build/sample.dgenrc" "$configdir/all/dgenrc"
        chown $user:$user "$configdir/all/dgenrc"
    fi

    ensureKeyValue "joy_pad1_a" "joystick0-button0" $configdir/all/dgenrc
    ensureKeyValue "joy_pad1_b" "joystick0-button1" $configdir/all/dgenrc
    ensureKeyValue "joy_pad1_c" "joystick0-button2" $configdir/all/dgenrc
    ensureKeyValue "joy_pad1_x" "joystick0-button3" $configdir/all/dgenrc
    ensureKeyValue "joy_pad1_y" "joystick0-button4" $configdir/all/dgenrc
    ensureKeyValue "joy_pad1_z" "joystick0-button5" $configdir/all/dgenrc
    ensureKeyValue "joy_pad1_mode" "joystick0-button6" $configdir/all/dgenrc
    ensureKeyValue "joy_pad1_start" "joystick0-button7" $configdir/all/dgenrc

    ensureKeyValue "joy_pad2_a" "joystick1-button0" $configdir/all/dgenrc
    ensureKeyValue "joy_pad2_b" "joystick1-button1" $configdir/all/dgenrc
    ensureKeyValue "joy_pad2_c" "joystick1-button2" $configdir/all/dgenrc
    ensureKeyValue "joy_pad2_x" "joystick1-button3" $configdir/all/dgenrc
    ensureKeyValue "joy_pad2_y" "joystick1-button4" $configdir/all/dgenrc
    ensureKeyValue "joy_pad2_z" "joystick1-button5" $configdir/all/dgenrc
    ensureKeyValue "joy_pad2_mode" "joystick1-button6" $configdir/all/dgenrc
    ensureKeyValue "joy_pad2_start" "joystick1-button7" $configdir/all/dgenrc

    ensureKeyValue "emu_z80_startup" "drz80" $configdir/all/dgenrc
    ensureKeyValue "emu_m68k_startup" "cyclone" $configdir/all/dgenrc

    mkRomDir "megadrive-dgen"
    mkRomDir "segacd-dgen"
    mkRomDir "sega32x-dgen"

    setESSystem "Sega Mega Drive / Genesis" "megadrive-dgen" "~/RetroPie/roms/megadrive-dgen" ".smd .SMD .bin .BIN .gen .GEN .md .MD .zip .ZIP" "$rootdir/supplementary/runcommand/runcommand.sh 1 \"$md_inst/bin/dgen -f -r $configdir/all/dgenrc %ROM%\"" "genesis,megadrive" "megadrive"
    setESSystem "Sega CD" "segacd-dgen" "~/RetroPie/roms/segacd-dgen" ".smd .SMD .bin .BIN .md .MD .zip .ZIP .iso .ISO" "$rootdir/supplementary/runcommand/runcommand.sh 1 \"$md_inst/bin/dgen -f -r $configdir/all/dgenrc %ROM%\"" "segacd" "segacd"
    setESSystem "Sega 32X" "sega32x-dgen" "~/RetroPie/roms/sega32x-dgen" ".32x .32X .smd .SMD .bin .BIN .md .MD .zip .ZIP" "$rootdir/supplementary/runcommand/runcommand.sh 1 \"$md_inst/bin/dgen -f -r $configdir/all/dgenrc %ROM%\"" "sega32x" "sega32x"
}
