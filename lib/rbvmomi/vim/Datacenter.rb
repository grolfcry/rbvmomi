class RbVmomi::VIM::Datacenter
  # Traverse the given inventory +path+ to find a ComputeResource.
  def find_compute_resource path
    hostFolder.traverse path, RbVmomi::VIM::ComputeResource
  end

  # Find the Datastore with the given +name+.
  def find_datastore name
    datastore.find { |x| x.name == name }
  end

  # Traverse the given inventory +path+ to find a VirtualMachine.
  def find_vm path
    return traverse_folders_for_vm(vmFolder, path)
  end

  def traverse_folders_for_vm(folder, vmname)
    children = folder.children.find_all
    children.each do |child|
      if child.class == RbVmomi::VIM::VirtualMachine && child.name == vmname
        return child
      elsif child.class == RbVmomi::VIM::Folder
        vm = traverse_folders_for_vm(child, vmname)
        if vm then return vm end
      end
    end
    return false
  end
end

