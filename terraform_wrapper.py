import subprocess
import logging
import sys
import argparse

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def run_terraform_command(command):
    try:
        logging.info(f'Running Terraform command: {" ".join(command)}')
        process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        for stdout_line in iter(process.stdout.readline, ""):
            logging.info(stdout_line.strip())
        process.stdout.close()
        process.wait()
        if process.returncode != 0:
            for stderr_line in process.stderr.readlines():
                logging.error(stderr_line.strip())
            process.stderr.close()
            sys.exit(process.returncode)
    except Exception as e:
        logging.error(f'Error running command: {" ".join(command)}')
        logging.error(str(e))
        sys.exit(1)

def init(backend_config=None, var_file=None):
    """Initialize Terraform configuration"""
    command = ['terraform', 'init']
    if backend_config:
        command.extend(['-backend-config', backend_config])
    if var_file:
        command.extend(['-var-file', var_file])
    run_terraform_command(command)

def plan(var_file=None):
    """Generate and show an execution plan"""
    command = ['terraform', 'plan']
    if var_file:
        command.extend(['-var-file', var_file])
    run_terraform_command(command)

def validate():
    """Validate the Terraform configuration"""
    command = ['terraform', 'validate']
    run_terraform_command(command)

def apply(var_file=None):
    """Apply the Terraform configuration"""
    command = ['terraform', 'apply', '-auto-approve']
    if var_file:
        command.extend(['-var-file', var_file])
    run_terraform_command(command)

def destroy():
    """Destroy the Terraform-managed infrastructure"""
    command = ['terraform', 'destroy', '-auto-approve']
    run_terraform_command(command)

def output():
    """Show Terraform output values"""
    command = ['terraform', 'output']
    run_terraform_command(command)

def main():
    parser = argparse.ArgumentParser(description='Python wrapper for Terraform commands.')
    subparsers = parser.add_subparsers(dest='command')

    # init command
    parser_init = subparsers.add_parser('init', help='Initialize Terraform configuration')
    parser_init.add_argument('--backend-config', help='Path to a Terraform backend config file')
    parser_init.add_argument('--var-file', help='Path to a Terraform variables file')

    # plan command
    parser_plan = subparsers.add_parser('plan', help='Generate and show an execution plan')
    parser_plan.add_argument('--backend-config', help='Path to a Terraform backend config file')
    parser_plan.add_argument('--var-file', help='Path to a Terraform variables file')

    # validate command
    subparsers.add_parser('validate', help='Validate the Terraform configuration')

    # apply command
    parser_apply = subparsers.add_parser('apply', help='Apply the Terraform configuration')
    parser_apply.add_argument('--backend-config', help='Path to a Terraform backend config file')
    parser_apply.add_argument('--var-file', help='Path to a Terraform variables file')

    # destroy command
    subparsers.add_parser('destroy', help='Destroy the Terraform-managed infrastructure')

    # output command
    subparsers.add_parser('output', help='Show Terraform output values')

    args = parser.parse_args()

    if args.command == 'init':
        init(backend_config=args.backend_config, var_file=args.var_file)
    elif args.command == 'plan':
        init(backend_config=args.backend_config, var_file=args.var_file)
        validate()
        plan(var_file=args.var_file)
    elif args.command == 'validate':
        validate()
    elif args.command == 'apply':
        init(backend_config=args.backend_config, var_file=args.var_file)
        validate()
        apply(var_file=args.var_file)
    elif args.command == 'destroy':
        destroy()
    elif args.command == 'output':
        output()
    else:
        parser.print_help()

if __name__ == '__main__':
    main()
