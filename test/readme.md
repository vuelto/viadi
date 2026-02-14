# viadi Tests

This directory contains functional tests for the viadi plugin using [vader.vim](https://github.com/junegunn/vader.vim).

## Running Tests

### Quick Start

```bash
# Run all tests (from project root)
make test

# Syntax check only
make check
```

### Test Files

- `viadi_basic_tests.vader` - Tests for basic helper functions (adi_field, date_time_now, etc.)
- `viadi_header_tests.vader` - Tests for ADI header creation
- `viadi_qso_tests.vader` - Tests for QSO entry formatting
