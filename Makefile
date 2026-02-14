.PHONY: test test-syntax test-vader install-vader clean help

# Default target
all: test

# Run syntax checks on all vim files
test-syntax:
	@echo "Running syntax checks..."
	@for vimfile in autoload/*.vim plugin/*.vim; do \
		echo "  Checking $$vimfile..."; \
		vim -u NONE -N -es -c "source $$vimfile" -c "quit" 2>&1 | grep -v "^$$" || echo "    ✓"; \
	done

# Run vader tests
test-vader: 
	@echo "Running vader tests..."
	@vim -Nu <(cat test/vimrc 2>/dev/null || printf "filetype off\nset rtp+=test/vader.vim\nset rtp+=.\nfiletype plugin indent on") "+Vader! test/*.vader"

# Run all tests (syntax + vader)
test: test-syntax test-vader
	@echo ""
	@echo "All tests passed!"

# Quick syntax check only
check: test-syntax

help:
	@echo "Available targets:"
	@echo "  make test         - Run all tests (syntax + vader)"
	@echo "  make test-syntax  - Run only syntax checks"
	@echo "  make test-vader   - Run only vader tests"
	@echo "  make check        - Quick syntax check"
	@echo "  make help         - Show this help message"
