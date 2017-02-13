#!/usr/bin/env bash

if [ -z "$1" ];
then
  echo "You must supply an environment argument.";
  exit 1
fi

if [[ $# -eq 1 ]];
then
  projectname=$1
fi

cd ..
composer install
cd www

echo "Removing all custom directory:";
sudo rm -R sites/all/modules/custom
echo "Adding custom directory from composer:"
cp -R ../modules/custom/ sites/all/modules/

echo "Removing contrib directory:";
sudo rm -R sites/all/modules/contrib

echo "Remove drupal core from vendor:"
sudo rm -R ../vendor/drupal/drupal

echo "Create directory for contributed modules:"
mkdir sites/all/modules/contrib
echo "Adding contributed modules from composer:"
cp -R ../vendor/drupal/* sites/all/modules/contrib/

echo "Removing contrib {projectname}_features:";
sudo rm -R sites/all/modules/${projectname}_features
echo "Adding features from composer:"
cp -R ../modules/${projectname}_features/ sites/all/modules/

echo "Remove unnecessary folders:"
sudo rm -R ../modules/

echo "Create symlink to www:"
cd ..
sudo ln -s www/ web



