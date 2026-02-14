# viadi

viadi is a vim plugin that provides keybinding for creating Amature Data Interchange Format (ADIF) files. It helps quickly generate ADIF files with the necessary structure and content. Licensed under the [MIT License](https://opensource.org/licenses/MIT).
 
## Features

- Automatically generate the ADIF header
- Prompt for information when creating QSO entries

## Roadmap

- [x] Basic ADIF header generation
- [x] QSO entry formatting with field prompts
- [ ] User configuration for field defaults and formatting
- [ ] Additional field support (e.g. location, operator)
- [ ] Integration with external APIs for callsign lookup
- [ ] Improved error handling and validation

## Install

This plugin assumes you are on a Unix-like system. Specifically is uses system('date -u ...') to get the current date and time in UTC format.

For VIM 9.1 and later

```bash
git clone https://github.com/vuelto/viadi.git ~/.vim/pack/vuelto/start/viadi
```

Then restart Vim and the plugin will be automatically loaded.

## Default Bindings

- `<leader>adi` - Inserts the ADIF header
- `<leader>qso` - Start a new QSO record, prompts for field value

## ADIF Header Format

When you create a new ADIF file using the `<leader>adi` keybinding, the following header will be inserted:

``` txt 
<ADIF_VER:5>3.1.4 <EOH>
```

## QSO Entry Format

When you start a new QSO entry using the `<leader>qso` keybinding, you will be prompted to enter the following information. Time and date will be automatically filled in using UTC time. The resulting QSO entry will be formatted as follows:

``` txt 
<QSO_DATE:8>20260214 <TIME_ON:4>1845 <CALL:6>KF0AGP
<BAND:2>2m <MODE:2>FM <RST_SENT:2>59 <RST_RCVD:2>59 
<COMMENT:15>Simplex Parker <EOR>
```

## Running Tests

This plugin includes functional tests to catch syntax errors and verify functionality. 

```bash
# install vader.vim
git clone https://github.com/junegunn/vader.vim.git ~/.vim/pack/junegunn/start/vader.vim

# Run all tests (syntax check + functional tests)
make test

# Quick syntax check only
make check
```

## ADIF Notes

- The ADIF format is a standard for exchanging amateur radio contact information.
- Each field in the ADIF file is enclosed in angle brackets and includes the field name, the length of the field value, and the field value itself.
- The `<EOH>` tag indicates the end of the header section, and the `<EOR>` tag indicates the end of a QSO entry.
- This is the ADIF document that I am following: https://adif.org.uk/316/ADIF_316.htm
- It is almost certainly not the intention of the ADIF specification authors to directly edit ADIF files in a text editor. I am doing that anyway.
