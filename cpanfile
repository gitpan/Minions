requires 'perl', '5.008005';

requires 'Exception::Class', '1.38';
requires 'List::MoreUtils',  '0.33';
requires 'Package::Stash', '0.36';
requires 'Params::Validate', '1.10';
requires 'Sub::Name',      '0.09';

on test => sub {
    requires 'Test::Lib',  '0.002';
    requires 'Test::Most', '0.34';
};
