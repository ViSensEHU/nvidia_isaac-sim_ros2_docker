from setuptools import find_packages, setup
import os
from glob import glob

package_name = 'create3'

def files_in_dir(path):
    """Devuelve todos los archivos dentro de un directorio, sin incluir subcarpetas."""
    return [f for f in glob(path) if os.path.isfile(f)]

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),

        ('share/' + package_name, ['package.xml']),

        # Launch
        (os.path.join('share', package_name, 'launch'),
            glob('create3/launch/*.launch.py')),

        # URDF (solo archivos)
        (os.path.join('share', package_name, 'urdf'),
            files_in_dir('create3/urdf/*')),

        # URDF/sensors (si existe)
        (os.path.join('share', package_name, 'urdf', 'sensors'),
            glob('create3/urdf/sensors/*') if os.path.isdir('create3/urdf/sensors') else []),

        # Meshes (solo archivos)
        (os.path.join('share', package_name, 'meshes'),
            files_in_dir('create3/meshes/*')),

        # Subcarpetas dentro de meshes (recursivo)
        *[
            (os.path.join('share', package_name, 'meshes', subdir),
             glob(f'create3/meshes/{subdir}/*'))
            for subdir in os.listdir('create3/meshes')
            if os.path.isdir(os.path.join('create3/meshes', subdir))
        ],
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='isaac_sim',
    maintainer_email='isaac_sim@todo.todo',
    description='Create3 description package',
    license='TODO',
    entry_points={},
)
