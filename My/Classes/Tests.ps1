class One {
    [string] $OneName = "1 Default"

    One() {
        Write-Host "Empty Ctor1: 1: $($this.OneName)"
    }
    One([hashtable]$Props) {
        Write-Host "Start Ctor1: 1: $($this.OneName)"
        $this.Init($Props)
        Write-Host "End Ctor1: 1: $($this.OneName)"
    }

    hidden Init([hashtable]$Props) {
        foreach ($Prop in $Props.Keys) {
            $this.$Prop = $Props.$Prop
        }
    }

    [string] FunctionOne() {
        $this.OneName = "1 FunctionOne"
        return $this.OneName
    }
    [string] FunctionOne([string]$Param) {
        $this.OneName = "1 FunctionOne, Param:" + $Param
        return $this.OneName
    }

    [string] FunctionTwo() {
        $this.TwoName = "1 FunctionTwo"
        return $this.TwoName
    }
    [string] FunctionTwo([string]$Param) {
        $this.TwoName = "1 FunctionTwo, Param:" + $Param
        return $this.TwoName
    }
}

class Two : One {
    [string] $TwoName = "2 Default"

    Two() : base(@{
            OneName = "Empty Base Ctor2"
        }) {
        Write-Host "Empty Ctor2: 1: $($this.OneName), 2: $($this.TwoName)"
    }

    Two([hashtable]$Props) : base(@{
            OneName = "Props Base Ctor2"
        }) {
        Write-Host "Start Ctor2: 1: $($this.OneName), 2: $($this.TwoName)"
        $this.Init($Props)
        Write-Host "End Ctor2: 1: $($this.OneName), 2: $($this.TwoName)"
    }

    [string] FunctionTwo() {
        $this.TwoName = "2 FunctionTwo"
        return $this.TwoName
    }
    [string] FunctionTwo([string]$Param) {
        $this.TwoName = "2 FunctionTwo, Param:" + $Param
        return $this.TwoName
    }
}

class Three : Two {
    [string] $ThreeName = "3 Default"

    Three() : base(@{
            OneName = "Empty Base Ctor3"
        }) {
        Write-Host "Empty Ctor3: 1: $($this.OneName), 2: $($this.TwoName), 3: $($this.ThreeName)"
    }

    Three([hashtable]$Props) : base(@{
            OneName = "Props Base Ctor3"
        }) {
        Write-Host "Start Ctor3: 1: $($this.OneName), 2: $($this.TwoName), 3: $($this.ThreeName)"
        $this.Init($Props)
        Write-Host "End Ctor3: 1: $($this.OneName), 2: $($this.TwoName), 3: $($this.ThreeName)"
    }

    [string] FunctionTwo() {
        $this.TwoName = "3 FunctionTwo"
        return $this.TwoName
    }
    [string] FunctionTwo([string]$Param) {
        $this.TwoName = "3 FunctionTwo, Param:" + $Param
        return $this.TwoName
    }

    [string] FunctionThree() {
        $this.ThreeName = "3 FunctionThree"
        return $this.ThreeName
    }
    [string] FunctionThree([string]$Param) {
        $this.ThreeName = "3 FunctionThree, Param:" + $Param
        return $this.ThreeName
    }
}

Remove-Variable one
Remove-Variable two
Remove-Variable three
Remove-Variable empty
$empty = @{}

# $one = [One]::New(@{ OneName = "Inst new One" })

# $two = [Two]::New()
# $two = [Two]::New(@{ OneName = "Inst new Two" })
# $two = [Two]::New(@{ TwoName = "Inst new Two" })
# $two = [Two]::New(@{ OneName = "Inst new 2"; TwoName = "Inst new 2" })
# $three = [Three]::New(@{ OneName = "Inst new 3"; TwoName = "Inst new 3"; ThreeName = "Inst new 3" })

# $empty["One"] = New-Object -TypeName One
# $empty["Two"] = New-Object -TypeName Two

# $two = [Two]::New(@{
#         OneName = "OneName Set When Inst new Two"
#         TwoName = "TwoName Set When Inst new Two"
#     })

# $two
